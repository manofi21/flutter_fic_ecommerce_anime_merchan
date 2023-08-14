import '../../../../core/errors/exceptions.dart';

class AuthLocalDataSourceException extends UnknownException {
  AuthLocalDataSourceException(String value, StackTrace stackTrace) : super('Occure in AuthStorage$value', stackTrace) {
    print(stackTrace);
  }
}
