import '../../../../core/errors/exceptions.dart';

class AuthLocalDataSourceException extends UnknownException {
  AuthLocalDataSourceException(String value) : super('Occure in AuthStorage$value');
}
