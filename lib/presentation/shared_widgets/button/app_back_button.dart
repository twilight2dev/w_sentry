import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:w_sentry/res/app_colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onPressed,
    this.padding,
  });

  final Function()? onPressed;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: padding ?? const EdgeInsets.only(right: 8, left: 16),
      onPressed: onPressed ?? () => context.pop(),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.titleText.withOpacity(0.2),
          ),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.keyboard_arrow_left,
          color: AppColors.titleText,
          size: 24,
        ),
      ),
    );
  }
}
