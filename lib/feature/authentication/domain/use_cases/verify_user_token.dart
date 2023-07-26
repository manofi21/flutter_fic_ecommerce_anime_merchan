import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/result.dart';

import 'package:flutter_fic_ecommerce_warung_comicon/core/errors/failure.dart';

import '../../../../core/use_cases/future_result_use_case.dart';
import '../entities/login_user_result.dart';
import '../repos/auth_repo.dart';

class VerifyUserToken extends FutureResultUseCase<LoginUserResult, NoParams> {
  final AuthRepo authRepo;
  VerifyUserToken(this.authRepo);
  
  @override
  Future<Result<LoginUserResult, Failure>> processCall(NoParams params) async {
    try {
      final getUserAfterLogin = await authRepo.verifyUserToken();
      return Ok(getUserAfterLogin);
    } on AuthenticationFailure {
      rethrow;
    } on UnknownFailure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Occure in Verify User Token Use Cases : ${e.toString()}');
    }
  }

}
