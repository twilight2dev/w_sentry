import 'package:flutter/material.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_typography.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.width,
    this.height,
    this.radius,
    this.labelColor,
    this.enabled = true,
  }) : super(key: key);

  final String label;
  final Widget? icon;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final double? radius;
  final Color? labelColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final _height = height ?? 44;
    final _width = width ?? double.maxFinite;
    final _borderRadius = BorderRadius.circular(radius ?? 4);

    final _labelStyle = AppTypography.poppins_16px_w600.copyWith(color: AppColors.primary);

    final _child = FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          if (icon != null) const SizedBox(width: 10),
          Text(label, style: _labelStyle),
        ],
      ),
    );

    return AnimatedContainer(
      height: _height,
      width: _width,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        border: Border.all(color: AppColors.primary),
      ),
      child: TextButton(
        onPressed: enabled ? onPressed : null,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: _borderRadius),
        ),
        child: _child,
      ),
    );
  }
}
