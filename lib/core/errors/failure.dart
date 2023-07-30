import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);
  final String message;

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}

class NoMessageFailure extends Failure {
  const NoMessageFailure() : super("");
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(message);
}

class ProductFailure extends Failure {
  const ProductFailure(String message) : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message) : super(message);
}

