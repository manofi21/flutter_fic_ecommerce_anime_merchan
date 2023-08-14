import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../exception/auth_local_exception.dart';

class AuthLocalDataSource extends FlutterSecureStorage {
  static const _accessToken = "access_token";

  AuthLocalDataSource(secureStorage);

  AndroidOptions get _androidOptions => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<String?> getAccessToken() async {
    try {
      return read(
        key: _accessToken,
        aOptions: _androidOptions,
      );
    } catch (e, stackTrace) {
      throw AuthLocalDataSourceException(
        '(getAccessToken) : ${e.toString()}',
        stackTrace,
      );
    }
  }

  Future<void> saveAccessToken(String? token) async {
    try {
      return write(
        key: _accessToken,
        value: token,
        aOptions: _androidOptions,
      );
    } catch (e, stackTrace) {
      throw AuthLocalDataSourceException(
        '(saveAccessToken) : ${e.toString()}',
        stackTrace,
      );
    }
  }

  Future<void> clearToken() async {
    try {
      return deleteAll(aOptions: _androidOptions);
    } catch (e, stackTrace) {
      throw AuthLocalDataSourceException(
        '(clearToken) : ${e.toString()}',
        stackTrace,
      );
    }
  }
}
