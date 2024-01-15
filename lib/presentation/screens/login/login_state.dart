import 'package:w_sentry/data/source/remote/responses/auth/email_login_response.dart';

enum LoginStatus { initial, loading, failure, success }

class LoginState {
  LoginState({
    this.status = LoginStatus.initial,
    this.loginData,
  });

  final LoginStatus status;
  final EmailLoginResponseData? loginData;

  LoginState copyWith({
    LoginStatus? status,
    EmailLoginResponseData? loginData,
  }) {
    return LoginState(
      status: status ?? this.status,
      loginData: loginData ?? this.loginData,
    );
  }
}
