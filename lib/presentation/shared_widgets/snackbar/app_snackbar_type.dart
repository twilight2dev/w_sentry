import 'package:flutter/material.dart';
import 'package:w_sentry/res/app_colors.dart';

enum AppSnackBarType {
  error,
  help,
  success;

  Color get backgroundColor {
    switch (this) {
      case AppSnackBarType.error:
        return AppColors.contentText;
      case AppSnackBarType.help:
        return AppColors.contentText;
      case AppSnackBarType.success:
        return const Color(0xFF10945C);
    }
  }

  IconData get icon {
    switch (this) {
      case AppSnackBarType.error:
        return Icons.error_outline;
      case AppSnackBarType.help:
        return Icons.warning_amber_rounded;
      case AppSnackBarType.success:
        return Icons.check;
    }
  }
}
