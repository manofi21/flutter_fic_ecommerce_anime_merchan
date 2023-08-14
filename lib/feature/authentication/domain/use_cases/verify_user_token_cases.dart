import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/result.dart';

import 'package:flutter_fic_ecommerce_warung_comicon/core/errors/failure.dart';

import '../../../../core/use_cases/future_result_use_case.dart';
import '../entities/login_result_user.dart';
import '../repos/auth_repo.dart';

class VerifyUserTokenCases extends FutureResultUseCase<LoginResultUser, NoParams> {
  final AuthRepo authRepo;
  VerifyUserTokenCases(this.authRepo);
  
  @override
  Future<Result<LoginResultUser, Failure>> processCall(NoParams params) async {
    try {
      final getUserAfterLogin = await authRepo.verifyUserTokenCases();
      return Ok(getUserAfterLogin);
    } on Failure catch(error) {
      return Err(error);
    } catch (e, stackTrace) {
      return Err(UnknownFailure('Occure in Verify User Token Use Cases : ${e.toString()}', stackTrace));
    }
  }

}
