import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/common/extensions/extensions.dart';
import 'package:w_sentry/data/source/local/storage/local_storage.dart';

import 'auth_state.dart';

final authVMProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    localStorage: ref.watch(localStorageProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel({required this.localStorage}) : super(AuthState());

  final LocalStorage localStorage;

  Future<void> setLoggedInEmail(String? loggedInEmail) async {
    if (!loggedInEmail.isNullOrEmpty) {
      state = state.copyWith(loggedInEmail: loggedInEmail);
    }
  }

  Future<void> checkBiometricSetup() async {
    final isBiometricSetup = localStorage.isBiometricSetup.get();
    state = state.copyWith(isBiometricSetup: isBiometricSetup);
  }

  Future<void> logout() async {
    await localStorage.clearAll();
  }
}
