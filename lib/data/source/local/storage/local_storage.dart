// ignore_for_file: unused_field

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:w_sentry/data/enum/local_auth_type.dart';
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
  late final BasicKey<String> localAuthType;
  late final SecureKey passCode;
  late final SecureKey encryptedAccessToken;

  Future<void> initialize() async {
    _basicStorage = await Hive.openBox('hiveLocalStorage');
    _secureStorage = const FlutterSecureStorage();

    userEmail = BasicKey('userEmail', _basicStorage);
    localAuthType = BasicKey('localAuthType', _basicStorage);
    passCode = SecureKey('passCode', _secureStorage);
    encryptedAccessToken = SecureKey('encryptedAccessTokenByPasscode', _secureStorage);
  }

  Future<void> saveLoginInfo(EmailLoginResponseData data) async {
    await Future.wait([
      userEmail.set(data.email ?? ''),
    ]);
  }

  Future<void> clearAll() async {
    await Future.wait([
      userEmail.delete(),
      localAuthType.delete(),
      passCode.delete(),
      encryptedAccessToken.delete(),
    ]);
  }

  Future<void> saveAccessTokenByPasscode({required String accessToken, required String passcode}) async {
    // final encryptedData = CryptographyService.encrypt(accessToken, passcode);
    await encryptedAccessToken.set(accessToken);
  }

  Future<String> getAccessTokenByPasscode({required String passcode}) async {
    final encryptedData = await encryptedAccessToken.get() ?? '';
    // final decryptedData = CryptographyService.decrypt(encryptedData, passcode);
    return encryptedData;
  }

  LocalAuthType getLocalAuthType() {
    final localAuthTypeStr = localAuthType.get() ?? LocalAuthType.none.name;
    return LocalAuthType.values.firstWhere((element) => element.name == localAuthTypeStr);
  }
}
