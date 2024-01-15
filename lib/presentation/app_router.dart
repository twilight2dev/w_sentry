import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:w_sentry/common/services/navigator_service.dart';
import 'package:w_sentry/data/source/remote/responses/auth/email_login_response.dart';
import 'package:w_sentry/presentation/screens/biometric/setup_biometric_screen.dart';
import 'package:w_sentry/presentation/screens/biometric/verify_biometric_screen.dart';
import 'package:w_sentry/presentation/screens/home/home_screen.dart';
import 'package:w_sentry/presentation/screens/login/login_screen.dart';
import 'package:w_sentry/presentation/screens/splash/splash_screen.dart';

GoRouter? previousRouter;

final routerProvider = Provider<GoRouter>((ref) {
  return previousRouter = GoRouter(
    initialLocation: previousRouter?.location ?? AppScreens.splash.path,
    navigatorKey: ref.read(navigatorServiceProvider).key,
    routes: [
      GoRoute(
        path: AppScreens.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppScreens.login.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppScreens.main.path,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppScreens.setup_biometric.path,
        builder: (context, state) {
          if (state.extra is EmailLoginResponseData) {
            return SetupBiometricScreen(loginData: state.extra! as EmailLoginResponseData);
          }
          return const Scaffold();
        },
      ),
      GoRoute(
        path: AppScreens.verify_biometric.path,
        builder: (context, state) => const VerifyBiometricScreen(),
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const VerifyBiometricScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
    ],
  );
});

enum AppScreens {
  splash,
  login,
  main,
  setup_biometric,
  verify_biometric,
}

extension AppScreenExtension on AppScreens {
  String get path {
    switch (this) {
      case AppScreens.splash:
        return '/splash';
      case AppScreens.login:
        return '/login';
      case AppScreens.main:
        return '/';
      case AppScreens.setup_biometric:
        return '/setup_biometric';
      case AppScreens.verify_biometric:
        return '/verify_biometric';
    }
  }
}
