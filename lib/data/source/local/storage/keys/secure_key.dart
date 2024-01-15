part of '../local_storage.dart';

class SecureKey {
  final String key;
  final FlutterSecureStorage storage;

  SecureKey(this.key, this.storage);

  Future<void> set(String? value) async {
    return storage.write(key: key, value: value);
  }

  Future<String?> get() async {
    return storage.read(key: key);
  }

  Future<void> delete() async {
    return storage.delete(key: key);
  }
}
