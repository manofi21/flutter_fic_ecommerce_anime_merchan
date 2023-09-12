import 'package:bloc/bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/result_handler/no_params.dart';

import '../../../domain/use_cases/log_out_user.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogOutUserCases logOutUserCases;
  LogoutCubit(this.logOutUserCases) : super(LogoutState());

  Future<void> onLogout() async {
    emit(LogoutState.onLoading());

    final logOutUseCases = await logOutUserCases(NoParams());
    final getLogoutState = logOutUseCases.when(error: (err) {
      return LogoutState.onError(err.message);
    }, none: () {
      return LogoutState.onSuccess();
    });
    emit(getLogoutState);
  }
}
