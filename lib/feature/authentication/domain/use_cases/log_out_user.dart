import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/result_handler/option.dart';
import '../../../../core/use_cases/future_option_use_case.dart';
import '../repos/auth_repo.dart';

class LogOutUserCases extends FutureOptionUseCase<NoParams> {
  final AuthRepo authRepo;
  LogOutUserCases(this.authRepo);
  
  @override
  Future<Option<Failure>> processCall(NoParams params) async {
    try {
      await authRepo.logOutUser();
      return None();
    } on AuthenticationFailure {
      rethrow;
    } on UnknownFailure {
      rethrow;
    } catch (e, stackTrace) {
      throw UnknownFailure('Occure in Request User Login Use Cases : ${e.toString()}', stackTrace);
    }
  }

}