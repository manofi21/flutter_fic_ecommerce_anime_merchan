import '../../../../core/errors/exceptions.dart';

class AuthLocalDataSourceException extends UnknownException {
  const AuthLocalDataSourceException(String value) : super('Occure in AuthStorage$value');
}
