import 'dart:convert';

extension StringExt on String {
  String replaceLinebreakTagWith(String replace) {
    return replaceAll('<br />', replace).replaceAll('<br/>', replace).replaceAll('<br>', replace);
  }

  String toHtmlEscape() {
    return htmlEscape.convert(this);
  }

  String toCapitalCase() {
    final regex = RegExp(r'(?<=\s|^)\w');
    return replaceAll(regex, regex.firstMatch(this)?.group(0)?.toUpperCase() ?? '');
  }
}

extension NullableStringExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
