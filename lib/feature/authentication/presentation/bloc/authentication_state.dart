part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  final String message;
  const AuthenticationState(this.message);
  
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial() : super('');
}

class AuthenticationRegistrationLoading extends AuthenticationState {
  const AuthenticationRegistrationLoading() : super('');
}

class AuthenticationRegistrationError extends AuthenticationState {
  const AuthenticationRegistrationError(String message) : super(message);
}

class AuthenticationRegistrationComplete extends AuthenticationState {
  const AuthenticationRegistrationComplete() : super('');
}

class AuthenticationLoginLoading extends AuthenticationState {
  const AuthenticationLoginLoading() : super('');
}

class AuthenticationLoginError extends AuthenticationState {
  const AuthenticationLoginError(String message) : super(message);
}

class AuthenticationLoginComplete extends AuthenticationState {
  const AuthenticationLoginComplete() : super('');
}

