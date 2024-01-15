import 'package:intl/intl.dart';

extension DoubleExt on double {
  String toCurrency({
    int maximumFractionDigits = 2,
  }) {
    // final intValue = round();
    // final isInt = this - intValue == 0;
    final formatter = NumberFormat.currency(locale: 'en_US', symbol: '');
    formatter.maximumFractionDigits = maximumFractionDigits;
    formatter.minimumIntegerDigits = 1;
    formatter.currencyName = '';
    return formatter.format(this);
  }
}
