import 'package:http_interceptor/http_interceptor.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/http_request/remote_data_request.dart';
import '../modal/auth_model.dart';
import '../modal/login_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(LoginRequestModel loginRequest);
  Future<User> verifyMe();
}

class AuthRemoteDataSourceImpl extends RemoteDataRequest
    implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required InterceptedHttp http,
  }) : super(http: http);

  @override
  Future<AuthModel> login(LoginRequestModel loginRequest) async {
    try {
      final authResult = await postRequest<AuthModel>(
        '/api/auth/local',
        fromMap: AuthModel.fromJson,
        bodyParameter: loginRequest.toJson(),
      );
      return authResult;
    } on HttpException {
      rethrow;
    } catch (e) {
      throw UnknownException(
        'Occure in Auth Remote Data Source(login) : ${e.toString()}',
      );
    }
  }

  @override
  Future<User> verifyMe() async {
    try {
      final verifyResult = await getRequest<User>(
        '/api/users/me',
        fromMap: User.fromJson,
      );
      return verifyResult;
    } on HttpException {
      rethrow;
    } catch (e) {
      throw UnknownException(
        'Occure in Auth Remote Data Source(verivy) : ${e.toString()}',
      );
    }
  }
}
