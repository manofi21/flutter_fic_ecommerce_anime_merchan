class HttpException implements Exception {
  final String message;
  const HttpException(this.message);
}

// class AuthStorageException implements Exception {
//   final String value;
//   const AuthStorageException(this.value);
// }

class UnknownException implements Exception {
  final String message;
  const UnknownException(this.message);
}

class AuthStorageException extends UnknownException {
  AuthStorageException(String value) : super('Occure in AuthStorage$value');
}
