import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/errors/exceptions.dart';

class AuthStorage {
  static const _accessToken = "access_token";

  final FlutterSecureStorage secureStorage;
  AuthStorage(this.secureStorage);

  AndroidOptions get _androidOptions => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<String?> getAccessToken() async {
    try {
      return secureStorage.read(
        key: _accessToken,
        aOptions: _androidOptions,
      ); 
    } catch (e) {
      throw AuthStorageException('(getAccessToken) : ${e.toString()}');
    }
  }

  Future<void> saveAccessToken(String? token) async {
    try {
      return secureStorage.write(
        key: _accessToken,
        value: token,
        aOptions: _androidOptions,
      ); 
    } catch (e) {
      throw AuthStorageException('(saveAccessToken) : ${e.toString()}');
    }
  }
}
