import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:w_sentry/res/app_colors.dart';

class SystemUtils {
  static Future<void> setStatusBarLight() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: AppColors.white, // Color for Android
          statusBarBrightness: Brightness.light, // Dark == white status bar -- for IOS.
        ),
      );
    });
  }

  static Future<void> setStatusBarDark() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: AppColors.black, // Color for Android
          statusBarBrightness: Brightness.dark, // Dark == white status bar -- for IOS.
        ),
      );
    });
  }

  static Future<void> setStatusBarTransparent() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    });
  }

  static Future<void> setStatusBarTransparentWithDarkIcon() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));
    });
  }

  static Future<void> setOrientationPortrait() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ]);
    });
  }
}
