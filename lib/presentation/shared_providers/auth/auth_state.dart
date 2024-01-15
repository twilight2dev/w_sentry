class AuthState {
  AuthState({
    this.isBiometricSetup = false,
    this.loggedInEmail,
  });

  final bool isBiometricSetup;
  final String? loggedInEmail;

  AuthState copyWith({
    bool? isBiometricSetup,
    String? loggedInEmail,
  }) {
    return AuthState(
      isBiometricSetup: isBiometricSetup ?? this.isBiometricSetup,
      loggedInEmail: loggedInEmail ?? this.loggedInEmail,
    );
  }
}
