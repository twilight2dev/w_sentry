import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/data/repository/auth_repository.dart';
import 'package:w_sentry/data/repository/repository.dart';
import 'package:w_sentry/data/source/local/storage/local_storage.dart';
import 'package:w_sentry/data/source/remote/params/auth/email_login_param.dart';
import 'package:w_sentry/presentation/screens/login/login_state.dart';

final loginVMProvider = StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(ref.watch(authRepositoryProvider), ref.watch(localStorageProvider));
});

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel(this._authRepository, this._localStorage) : super(LoginState());

  final AuthRepository _authRepository;
  final LocalStorage _localStorage;

  final EmailLoginParam _loginParm = EmailLoginParam(
      // email: 't@skychain.live',
      // password: 'W3lcom3123@@',
      );

  void updateUserName(String? value) {
    _loginParm.email = value ?? _loginParm.email;
  }

  void updatePassword(String? value) {
    _loginParm.password = value ?? _loginParm.password;
  }

  Future<void> login() async {
    state = state.copyWith(status: LoginStatus.loading);
    log('login with:\nemail: ${_loginParm.email}\npassword: ${_loginParm.password}');
    final result = await _authRepository.login(_loginParm);
    result.when(
      success: (data) async {
        if (data != null) {
          await _localStorage.saveLoginInfo(data);
          state = state.copyWith(
            status: LoginStatus.success,
            loginData: data,
          );
        } else {
          state = state.copyWith(status: LoginStatus.failure);
        }
      },
      failure: (error) {
        state = state.copyWith(status: LoginStatus.failure);
      },
    );
  }
}
