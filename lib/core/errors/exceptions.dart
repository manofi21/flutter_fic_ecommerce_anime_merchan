import 'package:equatable/equatable.dart';

class BaseExceptions extends Equatable implements Exception {
  const BaseExceptions(this.message);
  final String message;

  @override
  String toString() => message;

  @override
  List<Object> get props => [];
}

class HttpException extends BaseExceptions {
  const HttpException(String message) : super(message);
}

class UnknownException extends BaseExceptions {
  const UnknownException(String message) : super(message);
}