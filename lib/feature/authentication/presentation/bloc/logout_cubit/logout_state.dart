part of 'logout_cubit.dart';

class LogoutState {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final bool isInit;
  final String msgError;

  LogoutState({
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.msgError = '',
    this.isInit = true,
  });

  static LogoutState onSuccess() {
    return LogoutState(
      isError: false,
      isInit: false,
      isLoading: false,
      isSuccess: true,
    );
  }

  static LogoutState onError(String msgError) {
    return LogoutState(
      isError: true,
      isInit: false,
      isLoading: false,
      isSuccess: false,
      msgError: msgError,
    );
  }

  static LogoutState onLoading() {
    return LogoutState(
      isError: false,
      isInit: false,
      isLoading: true,
      isSuccess: false,
    );
  }
}
