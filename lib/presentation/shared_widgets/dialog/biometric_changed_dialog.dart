import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:w_sentry/presentation/app_router.dart';
import 'package:w_sentry/presentation/shared_widgets/button/app_filled_button.dart';
import 'package:w_sentry/res/app_dimens.dart';
import 'package:w_sentry/res/app_typography.dart';

class BiometricChangedDialog extends ConsumerWidget {
  const BiometricChangedDialog({Key? key}) : super(key: key);

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
            const Text(
              'Fingerprint Changes Detected',
              style: AppTypography.poppins_18px_w600,
            ),
            const Text(
              "We've detected changes to the fingerprints on your device. For security reasons, you are required to login again.",
              style: AppTypography.poppins_14px_w500,
            ),
            const SizedBox(height: 20),
            AppFilledButton(
              onPressed: () {
                context.go(AppScreens.login.path);
              },
              label: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
