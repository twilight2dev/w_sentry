import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:w_sentry/data/enum/local_auth_type.dart';
import 'package:w_sentry/presentation/app_router.dart';
import 'package:w_sentry/presentation/base/base_stateful_widget.dart';
import 'package:w_sentry/presentation/shared_providers/auth/auth_viewmodel.dart';
import 'package:w_sentry/presentation/shared_widgets/animations/faded/infinity_faded.dart';
import 'package:w_sentry/presentation/shared_widgets/app_logo.dart';

class SplashScreen extends BaseStatefulWidget {
  const SplashScreen({super.key});

  @override
  BaseState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      ref.read(authVMProvider.notifier).checkLocalAuthSetup();
    });
  }

  void listenAuthState() {
    ref.listen(authVMProvider, (previous, current) {
      if (current.localAuthType != LocalAuthType.none) {
        context.go(AppScreens.verify_biometric.path);
      } else {
        context.go(AppScreens.login.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    listenAuthState();
    return const Scaffold(
      body: Center(
        child: InfinityLoopFadeTransition(child: AppLogo()),
      ),
    );
  }
}
