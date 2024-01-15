import 'dart:async';

import 'package:flutter/material.dart';
import 'package:w_sentry/common/services/messenger_service.dart';
import 'package:w_sentry/common/utils/session_management.dart';
import 'package:w_sentry/presentation/app_theme.dart';
import 'package:w_sentry/presentation/base/base_stateful_widget.dart';
import 'package:w_sentry/res/app_strings.dart';

import 'app_router.dart';

class Application extends BaseStatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  BaseState<Application> createState() => _ApplicationState();
}

class _ApplicationState extends BaseState<Application> {
  @override
  void onPause() {
    super.onPause();
    SessionMananagent.setAccessToken('');
  }

  @override
  Future<void> onResume() async {
    super.onResume();
    final currentLocation = ref.read(routerProvider).location;
    if (currentLocation == AppScreens.main.path) {
      ref.read(routerProvider).go(AppScreens.verify_biometric.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: ref.read(messengerServiceProvider).key,
      theme: AppTheme.themeData,
      routerConfig: router,
    );
  }
}
