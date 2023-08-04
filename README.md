# flutter_fic_ecommerce_warung_comicon

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

-----------------------------------------
1. Run this to inside server first.
`ssh jagoflutterfic@103.150.93.77`

2. Go to Admin by run:
`103.150.93.77:1341/admin`

# Error Handling
1. Membuat class exception dan failure terlebih dahulu seperti di seperti di file : 
a. `lib\core\errors\exceptions.dart` untuk handling exception. Biasanya akan di throw di bagian data seperti _data source_ atau _http request_
b. `lib\core\errors\failure.dart` untuk handling failure. Biasanya akan di throw di bagian domain seperti _repository_ dan _use cases_ 

2. Bawah clean architecture dimulai dari _data source_. Error handling dimulai dari data source.. Dan, karena penggunaan data souce ada http request, dimulai dengan HTTP request.

a. HTTP Request _try-catch_
Mengimplement `Exception` di HTPP Request menggunakan class `HttpException` yang sudah di implements dengan `Exception`

```dart
class HttpException implements Exception {
  final String message;
  const HttpException(this.message);
}
```

Try catch http request sendiri bisa di pasang di:

- class Http Interceptor: 

Throw didalam function response yang ada di class Interceptor. Untuk case yang di throw ketika status codenya bukan 200.

```dart
class HttpRequestInterceptor implements InterceptorContract {
  final AuthLocalDataSource authStorage;
  HttpRequestInterceptor(this.authStorage);
 ...

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // Throw the Exception here
    if (data.statusCode != 200) {
        throw HttpException('Add Message Error Here');
    }

    return data;
  }
```

- class Http Request:

membuat check try-catch request di tiap function berebda (di function GET, POST, PUT, dan DELETE). Dan membuat Exception jika statusCode nya bukan 200(sama seperti case di atas.). Dan untuk case ini karena di dalam try sudah melakukan throw maka tambahkan satu kondisi _on_ dan _rethrow_:

```dart
  Future<T> getRequest<T>(...) async {
    try {
        final response = await http.get(...);
        // Throw the Exception here
        if (data.statusCode != 200) {
            throw HttpException('Add Message Error Here');
        }
        ...
    } on HttpException {
        rethrow;
    } catch (e) {
        throw HttpException(e.toString())
    }
  }
```

lalu pada data source repo impl, hanya perlu melakuka _rethrow_ lagi saja dengan keyword _on_:
```dart
abstract class AuthRemoteDataSource {
  Future<AuthModel> login(LoginRequestModel loginRequest);
}

class AuthRemoteDataSourceImpl extends RemoteDataRequest
    implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required InterceptedHttp http,
  }) : super(http: http);

  @override
  Future<AuthModel> login(LoginRequestModel loginRequest) async {
    try {
      final authResult = await postRequest<AuthModel>(...);
      return authResult;
    } on HttpException {
      rethrow;
    } catch (e) {
      throw UnknownException(
        'Occure in Auth Remote Data Source(login) : ${e.toString()}',
      );
    }
  }
}
```

-----------------------
### Checking Token Kosong
--Dari Core--
1. Di exception.dart : Buat `NoTokenSaved`
2. Di file http_request_interceptor.dart: Melakukan throw `NoTokenSaved` jika getToken kosong dan kondisi jika endpoint membutuhkan token.
```dart
  final getToken = await authStorage.getAccessToken();
  final currentRequest = data.url;
  final apiWithoutCheckAPI = ['/api/auth/local', '/api/auth/local/register'];

  if ((getToken ?? '').isEmpty &&
      !apiWithoutCheckAPI.any((e) => currentRequest.contains(e))) {
    throw const NoTokenSaved();
  }
```
--Dari Data Layer--
3. Di auth_remote_data_source.dart: ganti `on HttpException` ke `on BaseExceptions` di `verifyMe()`
4. di login_result_user.dart: tambahkan `empty()`
```dart
  static LoginResultUser empty() {
    return const LoginResultUser(username: '', email: '');
  }
```
5. di auth_repo_impl.dart: menambahkan `on NoTokenSaved` untuk mereturn 
`LoginResultUser.empty()`
```dart
...
  } on NoTokenSaved {
    return LoginResultUser.empty();
  } ...
```
--Dari Domain Layer--
~~6. verify_user_token_cases.dart: Tidak terdapat update~~
7. Di authentication_state.dart: menambahkan `AuthenticationNoTokenSaved`
```dart
  class AuthenticationNoTokenSaved extends AuthenticationState {
    const AuthenticationNoTokenSaved() : super('');
  }
```
8. Di authentication_bloc.dart: Menambahkan kondisi jika result mereturn `LoginResultUser.empty()`
```dart
  ok: (ok) {
    if (ok == LoginResultUser.empty()) {
      emit(const AuthenticationNoTokenSaved());
    }
    ...
  }
```
9. di auth_loading_overlay.dart: Menambakan kondisi jika `AuthenticationNoTokenSaved` menampilkan dialog
```dart
  if (state is AuthenticationNoTokenSaved) {
    await showConfirmDialog(
      context: context,
      message: "Silahkan Melakukan Login/Registrasi terlebih dahulu",
      ok: () {},
    );
    return;
  }
```