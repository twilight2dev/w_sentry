import 'package:flutter/widgets.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_typography.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      'WSentry',
      style: AppTypography.poppins_28px_w700.copyWith(
        color: AppColors.primary,
        fontSize: size,
        height: 1,
      ),
    );
  }
}
