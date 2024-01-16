import 'package:w_sentry/data/enum/local_auth_type.dart';

class AuthState {
  AuthState({
    this.localAuthType = LocalAuthType.none,
    this.loggedInEmail,
  });

  final LocalAuthType localAuthType;
  final String? loggedInEmail;

  AuthState copyWith({
    LocalAuthType? localAuthType,
    String? loggedInEmail,
  }) {
    return AuthState(
      localAuthType: localAuthType ?? this.localAuthType,
      loggedInEmail: loggedInEmail ?? this.loggedInEmail,
    );
  }
}
