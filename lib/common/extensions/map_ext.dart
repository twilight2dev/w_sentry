extension MapExt on Map<String, dynamic> {
  T valueOrDefault<T>(String key, {T? defaultValue}) {
    if (containsKey(key) && this[key] != null) {
      return this[key];
    } else if (defaultValue != null) {
      return defaultValue;
    } else {
      return {
        int: 0,
        String: '',
        double: 0.0,
        bool: false,
      }[T] as T;
    }
  }
}
