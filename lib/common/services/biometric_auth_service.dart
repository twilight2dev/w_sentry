import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/common/utils/session_management.dart';

final biometricAuthServiceProvider = Provider<BiometricAuthService>((ref) => BiometricAuthService());

enum BiometricErrorType {
  unknown,
  notAvailable,
  noBiometricEnrolled,
  noHardware,
  canceled,
  needSetup,
  timeout,
}

// class BiometricAuthResponse {
//   BiometricAuthResponse({required this.data, required this.error});

//   final String? data;
//   final BiometricErrorType? error;

//   factory BiometricAuthResponse.failure(BiometricErrorType error) {
//     return BiometricAuthResponse(error: error, data: null);
//   }

//   factory BiometricAuthResponse.success(String data) {
//     return BiometricAuthResponse(error: null, data: data);
//   }
// }

class BiometricAuthService {
  final String storageName = 'wsentry_biometric_storage';

  Future<BiometricStorageFile> getStorage({required String title}) async {
    return BiometricStorage().getStorage(
      storageName,
      options: StorageFileInitOptions(),
      promptInfo: PromptInfo(
        androidPromptInfo: AndroidPromptInfo(
          title: title,
          description: 'Access Safely, Access Fast',
        ),
      ),
    );
  }

  Future<BiometricErrorType?> setup(String accessToken) async {
    final error = await checkAvailable();
    if (error != null) {
      return error;
    }

    return _safeCall(
      callback: () async {
        final storage = await getStorage(title: 'Setup Fingerprint!');
        await storage.write(accessToken);
        SessionMananagent.setAccessToken(accessToken);
        return null;
      },
    );
  }

  Future<BiometricErrorType?> verify() async {
    final error = await checkAvailable();
    if (error != null) {
      if (error == BiometricErrorType.noBiometricEnrolled) {
        return BiometricErrorType.needSetup;
      }
      return error;
    }

    return _safeCall(
      callback: () async {
        final storage = await getStorage(title: 'Verify Fingerprint!');
        final storedData = await storage.read();
        if (storedData == null || storedData.isEmpty) {
          return BiometricErrorType.needSetup;
        }
        SessionMananagent.setAccessToken(storedData);
        return null;
      },
    );
  }

  Future<BiometricErrorType?> checkAvailable() async {
    final canSetupBiomeitric = await BiometricStorage().canAuthenticate();
    if (canSetupBiomeitric == CanAuthenticateResponse.success) {
      return null;
    } else {
      return canSetupBiomeitric.toBiometricErrorType();
    }
  }

  Future<void> clearData() async {
    final storage = await getStorage(title: 'Setup Fingerprint!');
    await storage.delete();
  }

  Future<BiometricErrorType?> _safeCall({required Future<BiometricErrorType?> Function() callback}) async {
    try {
      final error = await callback();
      return error;
    } on AuthException catch (e) {
      return e.toBiometricErrorType();
    }
  }
}

extension BiometricErrorTypeExt on BiometricErrorType {
  String get message {
    switch (this) {
      case BiometricErrorType.noBiometricEnrolled:
        return 'No fingerprint registered on your device';
      case BiometricErrorType.notAvailable:
        return 'No biometrics detected on your device';
      case BiometricErrorType.noHardware:
        return 'Your device does not support fingerprint authentication';
      case BiometricErrorType.canceled:
        return 'Fingerprint setup canceled by the user';
      case BiometricErrorType.timeout:
        return 'Fingerprint setup timed out';
      default:
        return 'Unsupported';
    }
  }

  List<String> get guideSteps {
    switch (this) {
      case BiometricErrorType.noBiometricEnrolled:
        return [
          'Go to your device settings and register a fingerprint.',
          'Ensure your device has a functional fingerprint sensor.'
        ];
      case BiometricErrorType.notAvailable:
        return [
          'Ensure your device supports fingerprint recognition.',
          "Make sure your device's biometric feature is enabled in the settings.",
        ];
      case BiometricErrorType.noHardware:
        return [
          'Confirm your device has a fingerprint sensor.',
          'If not, consider upgrading to a device with fingerprint support.',
        ];
      case BiometricErrorType.canceled:
        return [
          'Retry the setup process and follow the instructions carefully.',
          'Ensure you do not cancel the setup prematurely.',
        ];
      case BiometricErrorType.timeout:
        return [
          'Restart the setup process.',
          'Ensure your device is functioning properly.',
        ];
      default:
        return [];
    }
  }
}

extension CanAuthenticateResponseExt on CanAuthenticateResponse {
  BiometricErrorType? toBiometricErrorType() {
    switch (this) {
      case CanAuthenticateResponse.success:
        return null;
      case CanAuthenticateResponse.errorNoBiometricEnrolled:
        return BiometricErrorType.noBiometricEnrolled;
      case CanAuthenticateResponse.errorHwUnavailable:
        return BiometricErrorType.notAvailable;
      case CanAuthenticateResponse.errorNoHardware:
        return BiometricErrorType.noHardware;
      default:
        return BiometricErrorType.unknown;
    }
  }
}

extension AuthExceptionExt on AuthException {
  BiometricErrorType? toBiometricErrorType() {
    switch (code) {
      case AuthExceptionCode.userCanceled:
      case AuthExceptionCode.canceled:
        return BiometricErrorType.canceled;
      case AuthExceptionCode.timeout:
        return BiometricErrorType.timeout;
      default:
        return BiometricErrorType.unknown;
    }
  }
}
