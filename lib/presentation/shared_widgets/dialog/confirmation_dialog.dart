import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/common/services/navigator_service.dart';
import 'package:w_sentry/presentation/shared_widgets/button/app_gradient_button.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_dimens.dart';
import 'package:w_sentry/res/app_typography.dart';

class ConfirmationDialog extends ConsumerWidget {
  const ConfirmationDialog({
    Key? key,
    this.title,
    this.content,
    this.confirmLabel,
    this.cancelLabel,
    this.onConfirm,
    this.onCancel,
  })  : assert(title != null || content != null),
        super(key: key);

  final String? title;
  final Widget? content;
  final String? confirmLabel;
  final String? cancelLabel;
  final Function()? onConfirm;
  final Function()? onCancel;

  void _onCancel(WidgetRef ref) {
    ref.read(navigatorServiceProvider).back();
    if (onCancel != null) onCancel!();
  }

  void _onConfirm(WidgetRef ref) {
    ref.read(navigatorServiceProvider).back();
    if (onConfirm != null) onConfirm!();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      insetPadding: const EdgeInsets.all(PaddingDefault.medium),
      child: Padding(
        padding: const EdgeInsets.all(PaddingDefault.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              Text(title!, style: AppTypography.poppins_18px_w600.copyWith(color: AppColors.titleText)),
              const SizedBox(height: 10),
            ],
            if (content != null) ...[
              DefaultTextStyle(style: AppTypography.poppins_14px_w400, child: content!),
              const SizedBox(height: 20),
            ],
            if (onConfirm != null)
              AppFilledButton(
                onPressed: () => _onConfirm(ref),
                label: confirmLabel ?? 'Confirm',
              ),
            if (onConfirm != null && onCancel != null) const SizedBox(height: 10),
            if (onCancel != null)
              AppFilledButton(
                onPressed: () => _onCancel(ref),
                label: cancelLabel ?? 'Cancel',
              ),
          ],
        ),
      ),
    );
  }
}
