import 'package:flutter/widgets.dart';

extension TextStyleExt on TextStyle {
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }
}
