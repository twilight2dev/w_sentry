import 'package:w_sentry/common/constants/regex.dart';

class ValidatorUtils {
  static String? requiredFieldValidator(String? value, {required String fieldLabel}) {
    if (value?.trim().isEmpty == true) {
      return '$fieldLabel is required';
    }
    return null;
  }

  static String? noValidator(String? value) {
    return null;
  }

  static String? passwordValidator(String? value, {String fieldLabel = 'Password'}) {
    final result = requiredFieldValidator(value, fieldLabel: fieldLabel);
    // if (result == null && value != null && passwordRegex.hasMatch(value) == false) {
    //   return '$fieldLabel requires 6-20 characters.';
    // }
    return result;
  }

  static String? emailValidator(String? value, {String fieldLabel = 'Email'}) {
    final result = requiredFieldValidator(value, fieldLabel: fieldLabel);
    if (result == null && value != null && emailRegex.hasMatch(value) == false) {
      return '$fieldLabel is invalid';
    }
    return result;
  }
}
