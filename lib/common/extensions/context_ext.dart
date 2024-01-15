import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  List<T> findAllDescendantWidgetsOfExactType<T>() {
    final List<T> widgets = [];

    void visitElement(Element element) {
      if (element.widget is T) {
        widgets.add(element.widget as T);
      }
      element.visitChildren(visitElement);
    }

    visitChildElements(visitElement);
    return widgets;
  }
}
