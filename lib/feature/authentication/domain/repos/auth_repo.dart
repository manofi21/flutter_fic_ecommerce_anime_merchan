import '../entities/login_user_request.dart';
import '../entities/login_user_result.dart';

abstract class AuthRepo {
  Future<LoginUserResult> userLogin(LoginUserRequest userRequest);
  Future<LoginUserResult> verifyUserToken();
}