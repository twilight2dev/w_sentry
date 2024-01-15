import 'package:flutter/material.dart';

extension GlobalKeyExt on GlobalKey {
  Offset? get getWidgetPosition {
    return (currentContext?.findRenderObject() as RenderBox?)?.localToGlobal(Offset.zero);
  }

  double? get getWidgetWidth {
    return (currentContext?.findRenderObject() as RenderBox?)?.size.width;
  }

  double? get getWidgetHeight {
    return (currentContext?.findRenderObject() as RenderBox?)?.size.height;
  }
}
