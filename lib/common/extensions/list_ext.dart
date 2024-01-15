// ignore_for_file: sdk_version_since

extension ListExt<T> on List<T> {
  T? maxBy(double Function(T e) selector) {
    if (firstOrNull != null) {
      T maxElement = first;
      double maxPropertyValue = selector(maxElement);
      for (final element in this) {
        final propertyValue = selector(element);
        if (propertyValue > maxPropertyValue) {
          maxElement = element;
          maxPropertyValue = propertyValue;
        }
      }

      return maxElement;
    }

    return null;
  }

  T? minBy(double Function(T e) selector) {
    if (firstOrNull != null) {
      T minElement = first;
      double minPropertyValue = selector(minElement);
      for (final element in this) {
        final propertyValue = selector(element);
        if (propertyValue < minPropertyValue) {
          minElement = element;
          minPropertyValue = propertyValue;
        }
      }

      return minElement;
    }

    return null;
  }
}
