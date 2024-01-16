import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:w_sentry/data/source/local/storage/local_storage.dart';
import 'package:w_sentry/presentation/app_router.dart';
import 'package:w_sentry/presentation/base/base_stateful_widget.dart';
import 'package:w_sentry/presentation/shared_providers/auth/auth_viewmodel.dart';
import 'package:w_sentry/presentation/shared_widgets/dialog/confirmation_dialog.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_typography.dart';

class ConfirmPasscodeDialog extends BaseStatefulWidget {
  const ConfirmPasscodeDialog({
    super.key,
    required this.callback,
  });

  final Function() callback;

  @override
  BaseState<ConfirmPasscodeDialog> createState() => _ConfirmPasscodeDialogState();
}

class _ConfirmPasscodeDialogState extends BaseState<ConfirmPasscodeDialog> {
  final StreamController<bool> verificationNotifier = StreamController<bool>.broadcast();

  String passcode = '';
  int enterPassCodeCounter = 0;

  @override
  void initState() {
    super.initState();
    getPasscode();
  }

  Future<void> getPasscode() async {
    passcode = await ref.read(localStorageProvider).passCode.get() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: PasscodeScreen(
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
        isValidCallback: widget.callback,
        cancelButton: const Text(
          'Cancel',
          style: AppTypography.poppins_16px_w400,
        ),
        deleteButton: const Text(
          'Delete',
          style: AppTypography.poppins_16px_w400,
        ),
        shouldTriggerVerification: verificationNotifier.stream,
        cancelCallback: () {
          context.pop();
        },
      ),
    );
  }
}
