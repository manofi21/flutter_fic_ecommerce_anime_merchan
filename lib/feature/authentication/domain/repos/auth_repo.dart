import '../entities/login_request_user.dart';
import '../entities/login_result_user.dart';
import '../entities/register_request_user.dart';

abstract class AuthRepo {
  Future<LoginResultUser> userLogin(LoginRequestUser userRequest);
  Future<LoginResultUser> verifyUserTokenCases();
  Future<bool> registrationUser(RegisterRequestUser registerRequest);
}