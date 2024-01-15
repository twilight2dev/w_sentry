import 'package:flutter/material.dart';
import 'package:w_sentry/common/extensions/text_style_ext.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_dimens.dart';
import 'package:w_sentry/res/app_typography.dart';

class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      applyElevationOverlayColor: false,
      appBarTheme: AppBarTheme(
        toolbarHeight: 48,
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: AppColors.titleText),
        actionsIconTheme: const IconThemeData(color: AppColors.titleText),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.poppins_18px_w600.withColor(AppColors.titleText),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.background,
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      dividerTheme: const DividerThemeData(
        thickness: 1,
        color: AppColors.greyF1F1F1,
      ),
      buttonTheme: const ButtonThemeData(
        height: AppDimens.buttonHeight,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
