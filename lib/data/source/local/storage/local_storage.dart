// ignore_for_file: unused_field

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:w_sentry/data/source/remote/responses/auth/email_login_response.dart';

part './keys/basic_key.dart';
part './keys/secure_key.dart';

final localStorageProvider = Provider<LocalStorage>(
  (ref) => LocalStorage(),
);

class LocalStorage {
  late final Box _basicStorage;
  late final FlutterSecureStorage _secureStorage;

  late final BasicKey<String> userEmail;
  late final BasicKey<bool> isBiometricSetup;

  Future<void> initialize() async {
    _basicStorage = await Hive.openBox('hiveLocalStorage');
    _secureStorage = const FlutterSecureStorage();

    userEmail = BasicKey('userEmail', _basicStorage);
    isBiometricSetup = BasicKey('isBiometricSetup', _basicStorage);
  }

  Future<void> saveLoginInfo(EmailLoginResponseData data) async {
    await Future.wait([
      userEmail.set(data.email ?? ''),
    ]);
  }

  Future<void> clearAll() async {
    await Future.wait([
      userEmail.delete(),
    ]);
  }
}
