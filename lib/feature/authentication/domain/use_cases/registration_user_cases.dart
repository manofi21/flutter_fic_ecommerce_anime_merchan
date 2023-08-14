import 'package:flutter_fic_ecommerce_warung_comicon/core/errors/failure.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/use_cases/future_option_use_case.dart';

import '../../../../core/result_handler/option.dart';
import '../entities/register_request_user.dart';
import '../repos/auth_repo.dart';

class RegistrationUserCases extends FutureOptionUseCase<RegisterRequestUser> {
  final AuthRepo authRepo;
  RegistrationUserCases(this.authRepo);
  
  @override
  Future<Option<Failure>> processCall(RegisterRequestUser params) async {
    try {
      final getUserAfterLogin = await authRepo.registrationUser(params);
      if (getUserAfterLogin) {
        return None();
      }

      return Error(UnknownFailure('Somethings Wrong in getUserAfterLogin return false', StackTrace.current));
    } on Failure catch (err) {
      return Error(err);
    } catch (e, stackTrace) {
      throw UnknownFailure('Occure in Verify User Token Use Cases : ${e.toString()}', stackTrace);
    }
  }

}
