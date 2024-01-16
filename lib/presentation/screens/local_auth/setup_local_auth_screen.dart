import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:w_sentry/common/extensions/text_style_ext.dart';
import 'package:w_sentry/common/services/biometric_auth_service.dart';
import 'package:w_sentry/common/utils/session_management.dart';
import 'package:w_sentry/data/enum/local_auth_type.dart';
import 'package:w_sentry/data/source/local/storage/local_storage.dart';
import 'package:w_sentry/data/source/remote/responses/auth/email_login_response.dart';
import 'package:w_sentry/presentation/app_router.dart';
import 'package:w_sentry/presentation/base/base_stateful_widget.dart';
import 'package:w_sentry/presentation/shared_widgets/dialog/biometric_error_dialog.dart';
import 'package:w_sentry/presentation/shared_widgets/app_logo.dart';
import 'package:w_sentry/presentation/shared_widgets/button/app_filled_button.dart';
import 'package:w_sentry/presentation/shared_widgets/button/app_outlined_button.dart';
import 'package:w_sentry/presentation/shared_widgets/button/logout_button.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_dimens.dart';
import 'package:w_sentry/res/app_drawable.dart';
import 'package:w_sentry/res/app_typography.dart';

enum PasscodeStep { none, setup, confirm }

class SetupLocalAuthScreen extends BaseStatefulWidget {
  const SetupLocalAuthScreen({
    super.key,
    required this.loginData,
  });

  final EmailLoginResponseData loginData;

  @override
  BaseState<SetupLocalAuthScreen> createState() => _SetupBiometricScreenState();
}

class _SetupBiometricScreenState extends BaseState<SetupLocalAuthScreen> {
  final StreamController<bool> verificationNotifier = StreamController<bool>.broadcast();

  PasscodeStep passcodeStep = PasscodeStep.none;
  String enteredPasscode = '';

  Future<void> onBiometricSetup() async {
    final setupError = await ref.read(biometricAuthServiceProvider).setup(widget.loginData.idToken ?? '');
    if (mounted) {
      if (setupError != null) {
        openDialog(builder: (context) => BiometricErrorDialog(errorType: setupError));
      } else {
        await ref.read(localStorageProvider).localAuthType.set(LocalAuthType.biometric.name);
        if (mounted) {
          context.go(AppScreens.main.path);
        }
      }
    }
  }

  Future<void> onPasscodeSetup() async {
    final accessToken = widget.loginData.idToken ?? '';
    await ref.read(localStorageProvider).localAuthType.set(LocalAuthType.passcode.name);
    await ref.read(localStorageProvider).passCode.set(enteredPasscode);
    await ref.read(localStorageProvider).saveAccessTokenByPasscode(accessToken: accessToken, passcode: enteredPasscode);
    SessionMananagent.setAccessToken(accessToken);

    if (mounted) {
      context.go(AppScreens.main.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const AppLogo(size: 18),
            actions: const [LogoutButton()],
          ),
          body: Padding(
            padding: const EdgeInsets.all(PaddingDefault.large),
            child: Column(
              children: [
                const SizedBox(height: 20),
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
                  label: 'Setup your Fingerprint',
                  onPressed: onBiometricSetup,
                ),
                const SizedBox(height: 10),
                const TextLineBackground('Or'),
                const SizedBox(height: 10),
                AppOutlinedButton(
                  label: 'Setup your PIN',
                  onPressed: () {
                    setState(() {
                      passcodeStep = PasscodeStep.setup;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: Duration.zero,
          child: passcodeStep == PasscodeStep.setup
              ? PasscodeScreen(
                  backgroundColor: AppColors.black.withOpacity(0.92),
                  keyboardUIConfig: KeyboardUIConfig(
                    digitTextStyle: AppTypography.poppins_20px_w500.withColor(AppColors.white),
                  ),
                  title: Text(
                    'Enter your PIN',
                    style: AppTypography.poppins_20px_w600.withColor(AppColors.white),
                  ),
                  passwordEnteredCallback: (text) async {
                    setState(() {
                      enteredPasscode = text;
                      passcodeStep = PasscodeStep.confirm;
                    });
                  },
                  cancelButton: Text(
                    'Cancel',
                    style: AppTypography.poppins_16px_w400.withColor(AppColors.white),
                  ),
                  deleteButton: Text(
                    'Delete',
                    style: AppTypography.poppins_16px_w400.withColor(AppColors.white),
                  ),
                  shouldTriggerVerification: verificationNotifier.stream,
                  cancelCallback: () {
                    setState(() {
                      passcodeStep = PasscodeStep.none;
                    });
                  },
                )
              : const SizedBox(),
        ),
        AnimatedSwitcher(
          duration: Duration.zero,
          child: passcodeStep == PasscodeStep.confirm
              ? PasscodeScreen(
                  backgroundColor: AppColors.black.withOpacity(0.92),
                  title: Text(
                    'Confirm your PIN',
                    style: AppTypography.poppins_20px_w600.withColor(AppColors.white),
                  ),
                  passwordEnteredCallback: (text) {
                    final isValid = text == enteredPasscode;
                    verificationNotifier.add(isValid);
                    if (!isValid) {
                      showErrorMessage("The PIN you entered doesn't match");
                    }
                  },
                  isValidCallback: onPasscodeSetup,
                  cancelButton: Text(
                    passcodeStep == PasscodeStep.confirm ? 'Back' : 'Cancel',
                    style: AppTypography.poppins_16px_w400.withColor(AppColors.white),
                  ),
                  deleteButton: Text(
                    'Delete',
                    style: AppTypography.poppins_16px_w400.withColor(AppColors.white),
                  ),
                  shouldTriggerVerification: verificationNotifier.stream,
                  cancelCallback: () {
                    setState(() {
                      passcodeStep = PasscodeStep.setup;
                    });
                  },
                )
              : const SizedBox(),
        )
      ],
    );
  }
}

class TextLineBackground extends StatelessWidget {
  final String text;
  const TextLineBackground(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Divider(color: Colors.black26),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                text,
                style: AppTypography.poppins_14px_w400,
              ),
            ),
          ),
        )
      ],
    );
  }
}
