import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:w_sentry/common/services/biometric_auth_service.dart';
import 'package:w_sentry/common/utils/session_management.dart';
import 'package:w_sentry/data/enum/local_auth_type.dart';
import 'package:w_sentry/data/source/local/storage/local_storage.dart';
import 'package:w_sentry/presentation/app_router.dart';
import 'package:w_sentry/presentation/base/base_stateful_widget.dart';
import 'package:w_sentry/presentation/shared_widgets/dialog/biometric_changed_dialog.dart';
import 'package:w_sentry/presentation/shared_widgets/dialog/biometric_error_dialog.dart';
import 'package:w_sentry/presentation/shared_providers/auth/auth_viewmodel.dart';
import 'package:w_sentry/presentation/shared_widgets/app_logo.dart';
import 'package:w_sentry/presentation/shared_widgets/button/app_filled_button.dart';
import 'package:w_sentry/presentation/shared_widgets/button/logout_button.dart';
import 'package:w_sentry/presentation/shared_widgets/dialog/confirmation_dialog.dart';
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
  late final LocalAuthType localAuthType;
  final StreamController<bool> verificationNotifier = StreamController<bool>.broadcast();

  String passcode = '';
  int enterPassCodeCounter = 0;

  @override
  void initState() {
    super.initState();
    localAuthType = ref.read(localStorageProvider).getLocalAuthType();
    if (localAuthType == LocalAuthType.biometric) {
      onBiometricVerify();
    } else {
      getPasscode();
    }
  }

  Future<void> onBiometricVerify() async {
    final verifyError = await ref.read(biometricAuthServiceProvider).verify();
    if (mounted) {
      if (verifyError != null) {
        if (verifyError == BiometricErrorType.authChanged) {
          openDialog(builder: (context) => const BiometricChangedDialog());
        } else {
          openDialog(builder: (context) => BiometricErrorDialog(errorType: verifyError));
        }
      } else {
        context.go(AppScreens.main.path);
      }
    }
  }

  Future<void> getPasscode() async {
    passcode = await ref.read(localStorageProvider).passCode.get() ?? '';
  }

  Future<void> onPasscodeVerify() async {
    final accessToken = await ref.read(localStorageProvider).getAccessTokenByPasscode(passcode: passcode);
    SessionMananagent.setAccessToken(accessToken);
    if (mounted) {
      context.go(AppScreens.main.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return localAuthType == LocalAuthType.passcode
        ? PasscodeScreen(
            backgroundColor: AppColors.white,
            circleUIConfig: const CircleUIConfig(
              borderColor: AppColors.contentText,
              fillColor: AppColors.contentText,
            ),
            keyboardUIConfig: const KeyboardUIConfig(
              primaryColor: AppColors.contentText,
              digitTextStyle: AppTypography.poppins_20px_w500,
            ),
            title: const Text(
              'Enter your PIN',
              style: AppTypography.poppins_16px_w600,
            ),
            passwordEnteredCallback: (text) async {
              enterPassCodeCounter++;
              final isValid = passcode == text;
              verificationNotifier.add(isValid);
              if (!isValid) {
                if (enterPassCodeCounter == 3) {
                  openDialog(
                    barrierDismissible: false,
                    builder: (context) {
                      return ConfirmationDialog(
                        title: 'Security Alert',
                        content: const Text(
                          "It seems you've entered the wrong PIN code more than 3 times. For your account's security, you are now being logged out",
                        ),
                        confirmLabel: 'Logout',
                        onConfirm: () {
                          ref.read(authVMProvider.notifier).logout();
                          context.go(AppScreens.login.path);
                        },
                      );
                    },
                  );
                } else {
                  showErrorMessage('The PIN you entered is incorrect');
                }
              }
            },
            isValidCallback: onPasscodeVerify,
            cancelButton: const Text(
              'Logout',
              style: AppTypography.poppins_16px_w400,
            ),
            deleteButton: const Text(
              'Delete',
              style: AppTypography.poppins_16px_w400,
            ),
            shouldTriggerVerification: verificationNotifier.stream,
            cancelCallback: () {
              ref.read(authVMProvider.notifier).logout();
              context.go(AppScreens.login.path);
            },
          )
        : Scaffold(
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
                    onPressed: onBiometricVerify,
                  ),
                ],
              ),
            ),
          );
  }
}
