
import '../../../../core/errors/exceptions.dart';
import '../../../../core/http_request/remote_data_request.dart';
import '../modal/auth_model.dart';
import '../modal/login_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(LoginRequestModel loginRequest);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final RemoteDataRequest remoteDataRequest;
  AuthRemoteDataSourceImpl(this.remoteDataRequest);

  @override
  Future<AuthModel> login(LoginRequestModel loginRequest) async {
    try {
      final authResult = await remoteDataRequest.postRequest<AuthModel>(
        '/api/auth/local',
        fromMap: AuthModel.fromJson,
        bodyParameter: loginRequest.toJson()
      );
      return authResult;
    } on HttpException {
      rethrow;
    } catch (e) {
      throw UnknownException(
          'Occure in Auth Remote Data Source(login) : ${e.toString()}');
    }
  }
}
