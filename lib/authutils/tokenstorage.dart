// ignore_for_file: prefer_const_constructors

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Tokenstorage {
  static final FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
        encryptedSharedPreferences: true), //così dati salvati sono criptati
  );

  static Future<void> savetoken(String key, String value) async =>
      await _storage.write(key: key, value: value);

  static Future<String?> retrievetokenvalue(String key) async {
    String? token = await _storage.read(key: key);
    if (token != null) {
      return token;
    } else {
      return null;
    }
  }

  static Future<void> removetokenfromstorage(String key) async {
    //logout
    await _storage.delete(key: key);
  }
}
