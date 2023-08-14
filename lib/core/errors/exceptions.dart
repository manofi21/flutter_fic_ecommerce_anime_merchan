import 'package:equatable/equatable.dart';

class BaseExceptions extends Equatable implements Exception {
  const BaseExceptions(this.message);
  final String message;

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}

class CastingErrorException extends BaseExceptions {
  const CastingErrorException({required String className, required List<String> listCasting}) : super('Field that have null values is $listCasting in class $className');
}

class HttpException extends BaseExceptions {
  const HttpException(String message) : super(message);
}

class UnknownException extends BaseExceptions {
  final StackTrace stackTrace;
  UnknownException(String message, this.stackTrace) : super(message) {
    print(stackTrace);
  }
}

class NoTokenSaved extends BaseExceptions {
  const NoTokenSaved() : super('');
}