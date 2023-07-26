import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../exception/auth_local_exception.dart';

class AuthLocalDataSource extends FlutterSecureStorage{
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
    } catch (e) {
      throw AuthLocalDataSourceException('(getAccessToken) : ${e.toString()}');
    }
  }

  Future<void> saveAccessToken(String? token) async {
    try {
      debugPrint('Value Result : $token');
      return write(
        key: _accessToken,
        value: token,
        aOptions: _androidOptions,
      ); 
    } catch (e) {
      throw AuthLocalDataSourceException('(saveAccessToken) : ${e.toString()}');
    }
  }
}
