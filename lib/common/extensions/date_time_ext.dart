import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  DateTime getStartOfWeek() {
    return subtract(Duration(days: weekday - 1));
  }

  DateTime getEndOfWeek() {
    return add(Duration(days: DateTime.daysPerWeek - weekday));
  }

  bool isSame(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String defaultFormattedString() {
    return DateFormat('yyyy-MM-dd hh:mm a').format(this);
  }

  String to_DD_MMM_YYYY() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String compareDateTime({DateTime? compareDateTime}) {
    final Duration duration = (compareDateTime ?? DateTime.now()).difference(this);
    if (duration.inSeconds < 60) return "${duration.inSeconds} ${duration.inSeconds > 1 ? 'seconds' : 'second'} ago";
    if (duration.inMinutes < 60) return "${duration.inMinutes} ${duration.inMinutes > 1 ? 'minutes' : 'minute'} ago";
    if (duration.inHours < 24) return "${duration.inHours} ${duration.inHours > 1 ? 'hours' : 'hour'} ago";
    if (duration.inDays < 30) return "${duration.inDays} ${duration.inDays > 1 ? 'days' : 'day'} ago";
    final int monthAgo = duration.inDays ~/ 30;
    if (monthAgo < 12) return "${duration.inDays} ${duration.inSeconds > 1 ? 'months' : 'month'} ago";
    return DateFormat('MMM dd, yyyy').format(this);
  }
}

DateTime findNearestMonday() {
  final now = DateTime.now();
  final daysFromMonday2Now = now.weekday - 1;
  return now.subtract(Duration(days: daysFromMonday2Now));
}
