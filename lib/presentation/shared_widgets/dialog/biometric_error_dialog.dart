import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/common/services/biometric_auth_service.dart';
import 'package:w_sentry/common/services/navigator_service.dart';
import 'package:w_sentry/presentation/shared_widgets/button/app_filled_button.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_dimens.dart';
import 'package:w_sentry/res/app_typography.dart';

class BiometricErrorDialog extends ConsumerWidget {
  const BiometricErrorDialog({
    required this.errorType,
    Key? key,
  }) : super(key: key);

  final BiometricErrorType errorType;

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
              'Fingerprint Setup',
              style: AppTypography.poppins_18px_w600,
            ),
            Text(errorType.message, style: AppTypography.poppins_14px_w500),
            const SizedBox(height: 20),
            const Text('Troubleshooting Steps:', style: AppTypography.poppins_14px_w500),
            ...errorType.guideSteps.map(
              (guideStep) => _buildGuildStepLine(guideStep),
            ),
            const SizedBox(height: 20),
            AppFilledButton(
              onPressed: ref.read(navigatorServiceProvider).back,
              label: 'Confirm',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuildStepLine(String guideStep) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4,
            width: 4,
            margin: const EdgeInsets.only(right: 10, top: 4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.contentText,
            ),
          ),
          Expanded(
            child: Text(
              guideStep,
              style: AppTypography.poppins_12px_w400.copyWith(
                height: 1.2,
                color: AppColors.contentText.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
