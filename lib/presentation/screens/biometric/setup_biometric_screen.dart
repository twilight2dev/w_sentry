import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:w_sentry/common/services/biometric_auth_service.dart';
import 'package:w_sentry/data/source/local/storage/local_storage.dart';
import 'package:w_sentry/data/source/remote/responses/auth/email_login_response.dart';
import 'package:w_sentry/presentation/app_router.dart';
import 'package:w_sentry/presentation/base/base_stateful_widget.dart';
import 'package:w_sentry/presentation/screens/biometric/widgets/biometric_error_dialog.dart';
import 'package:w_sentry/presentation/shared_widgets/app_logo.dart';
import 'package:w_sentry/presentation/shared_widgets/button/app_gradient_button.dart';
import 'package:w_sentry/presentation/shared_widgets/button/logout_button.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_dimens.dart';
import 'package:w_sentry/res/app_drawable.dart';
import 'package:w_sentry/res/app_typography.dart';

class SetupBiometricScreen extends BaseStatefulWidget {
  const SetupBiometricScreen({
    super.key,
    required this.loginData,
  });

  final EmailLoginResponseData loginData;

  @override
  BaseState<SetupBiometricScreen> createState() => _SetupBiometricScreenState();
}

class _SetupBiometricScreenState extends BaseState<SetupBiometricScreen> {
  Future<void> onSetup() async {
    final setupError = await ref.read(biometricAuthServiceProvider).setup(widget.loginData.idToken ?? '');
    if (mounted) {
      if (setupError != null) {
        openDialog(builder: (context) => BiometricErrorDialog(errorType: setupError));
      } else {
        showSuccessMessage('Success! Fingerprint Set Up');
        ref.read(localStorageProvider).isBiometricSetup.set(true);
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
            const Text('Setup Fingerprint!', style: AppTypography.poppins_20px_w600),
            const Text('Secure Your App with a Personal Touch.', style: AppTypography.poppins_14px_w500),
            const SizedBox(height: 16),
            const Text(
              "Welcome to WSentry. To enhance the protection of your access, we've introduced Fingerprint Authentication. Setting up your Fingerprint is quick and easy!",
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
              label: 'Setup',
              onPressed: onSetup,
            ),
          ],
        ),
      ),
    );
  }
}
