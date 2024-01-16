import 'package:encrypt/encrypt.dart';

class CryptographyService {
  static String encrypt(String data, String passcode) {
    final key = Key.fromUtf8(passcode.padRight(32));
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  static String decrypt(String encryptedData, String passcode) {
    final key = Key.fromUtf8(passcode.padRight(32));
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
    return decrypted;
  }
}
