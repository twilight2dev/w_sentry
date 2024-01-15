import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:w_sentry/common/services/biometric_auth_service.dart';
import 'package:w_sentry/presentation/app_router.dart';
import 'package:w_sentry/presentation/base/base_stateful_widget.dart';
import 'package:w_sentry/presentation/screens/biometric/widgets/biometric_changed_dialog.dart';
import 'package:w_sentry/presentation/screens/biometric/widgets/biometric_error_dialog.dart';
import 'package:w_sentry/presentation/shared_widgets/app_logo.dart';
import 'package:w_sentry/presentation/shared_widgets/button/app_gradient_button.dart';
import 'package:w_sentry/presentation/shared_widgets/button/logout_button.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_dimens.dart';
import 'package:w_sentry/res/app_drawable.dart';
import 'package:w_sentry/res/app_typography.dart';

class VerifyBiometricScreen extends BaseStatefulWidget {
  const VerifyBiometricScreen({
    super.key,
  });

  @override
  BaseState<VerifyBiometricScreen> createState() => _VerifyBiometricScreenState();
}

class _VerifyBiometricScreenState extends BaseState<VerifyBiometricScreen> {
  @override
  void initState() {
    super.initState();
    onVerify();
  }

  Future<void> onVerify() async {
    final verifyError = await ref.read(biometricAuthServiceProvider).verify();
    if (mounted) {
      if (verifyError != null) {
        if (verifyError == BiometricErrorType.needSetup) {
          openDialog(builder: (context) => const BiometricChangedDialog());
        } else {
          openDialog(builder: (context) => BiometricErrorDialog(errorType: verifyError));
        }
      } else {
        context.go(AppScreens.main.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppLogo(size: 18),
        actions: const [LogoutButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(PaddingDefault.large),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text('Verify Your Fingerprint', style: AppTypography.poppins_20px_w600),
            const Text('Welcome Back!', style: AppTypography.poppins_14px_w500),
            const SizedBox(height: 16),
            const Text(
              'To maintain the highest level of security, WSentry requires you to verify your fingerprint code each time you return to the app from the background or after every 5 minutes of inactivity.',
              style: AppTypography.poppins_12px_w400,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SvgPicture.asset(
              AppDrawable.ic_android_fingerprint_svg,
              width: 100,
              colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            const SizedBox(height: 30),
            AppFilledButton(
              label: 'Verify',
              onPressed: onVerify,
            ),
          ],
        ),
      ),
    );
  }
}
