// AuthRepo
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/result.dart';

import 'package:flutter_fic_ecommerce_warung_comicon/core/errors/failure.dart';

import '../../../../core/use_cases/future_result_use_case.dart';
import '../entities/login_user_request.dart';
import '../entities/login_user_result.dart';
import '../repos/auth_repo.dart';

class RequestUserLogin extends FutureResultUseCase<LoginUserResult, LoginUserRequest> {
  final AuthRepo authRepo;
  RequestUserLogin(this.authRepo);
  
  @override
  Future<Result<LoginUserResult, Failure>> processCall(LoginUserRequest params) async {
    try {
      final getUserAfterLogin = await authRepo.userLogin(params);
      return Ok(getUserAfterLogin);
    } on AuthenticationFailure {
      rethrow;
    } on UnknownFailure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Occure in Request User Login Use Cases : ${e.toString()}');
    }
  }

}
