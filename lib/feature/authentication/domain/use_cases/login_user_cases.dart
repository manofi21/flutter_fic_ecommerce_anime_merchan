// AuthRepo
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/result.dart';

import 'package:flutter_fic_ecommerce_warung_comicon/core/errors/failure.dart';

import '../../../../core/use_cases/future_result_use_case.dart';
import '../entities/login_request_user.dart';
import '../entities/login_result_user.dart';
import '../repos/auth_repo.dart';

class LoginUserCases extends FutureResultUseCase<LoginResultUser, LoginRequestUser> {
  final AuthRepo authRepo;
  LoginUserCases(this.authRepo);
  
  @override
  Future<Result<LoginResultUser, Failure>> processCall(LoginRequestUser params) async {
    try {
      final getUserAfterLogin = await authRepo.userLogin(params);
      return Ok(getUserAfterLogin);
    } on AuthenticationFailure {
      rethrow;
    } on UnknownFailure {
      rethrow;
    } catch (e, stackTrace) {
      throw UnknownFailure('Occure in Request User Login Use Cases : ${e.toString()}', stackTrace);
    }
  }

}
