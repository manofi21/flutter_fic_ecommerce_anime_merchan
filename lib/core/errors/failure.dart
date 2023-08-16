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
  final StackTrace stackTrace;
  UnknownFailure(String message, this.stackTrace) : super(message) {
    print(stackTrace);
  }
}

class ProductFailure extends Failure {
  const ProductFailure(String message) : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message) : super(message);
}

class OrderFailure extends Failure {
  const OrderFailure(String message) : super(message);
}

class AddressFailure extends Failure {
  const AddressFailure(String message) : super(message);
}