part of '../local_storage.dart';

class BasicKey<T> {
  final String key;
  final Box storage;

  BasicKey(this.key, this.storage);

  Future<void> set(T value) async {
    return storage.put(key, value);
  }

  T? get() {
    return storage.get(key);
  }

  Future<void> delete() async {
    return storage.delete(key);
  }
}
