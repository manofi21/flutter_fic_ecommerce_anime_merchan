part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class OnRegistrationEvent extends AuthenticationEvent {
  final RegisterRequestUser registModel;
  final void Function() onSuccess;
  const OnRegistrationEvent({
    required this.registModel,
    required this.onSuccess,
  });
}

class OnLoginEvent extends AuthenticationEvent {
  final LoginRequestUser loginModel;
  final void Function() onSuccess;
  const OnLoginEvent({required this.loginModel, required this.onSuccess});
}

class OnVerifyTokenEvent extends AuthenticationEvent {
  const OnVerifyTokenEvent();
}
