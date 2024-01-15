import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:w_sentry/common/services/messenger_service.dart';
import 'package:w_sentry/common/services/navigator_service.dart';
import 'package:w_sentry/presentation/shared_widgets/snackbar/app_snackbar_type.dart';

abstract class BaseStatefulWidget extends ConsumerStatefulWidget {
  const BaseStatefulWidget({super.key});
}

abstract class BaseState<P extends BaseStatefulWidget> extends ConsumerState<P> with WidgetsBindingObserver {
  ///***************************************************************************
  /// LIFE CYCLE
  ///***************************************************************************
  AppLifecycleState lifeCycleState = AppLifecycleState.resumed;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onViewCreated();
      onResume();
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (lifeCycleState == AppLifecycleState.paused) {
        lifeCycleState = AppLifecycleState.resumed;
        onResume();
      }
    } else if (state == AppLifecycleState.paused) {
      if (lifeCycleState == AppLifecycleState.resumed) {
        lifeCycleState = AppLifecycleState.paused;
        onPause();
      }
    }
  }

  void onViewCreated() {}

  void onResume() {}

  void onPause() {}

  ///***************************************************************************
  /// NAVIGATOR
  ///***************************************************************************

  Future<T?> push<T extends Object?>(String location, {Object? extra}) {
    return context.push<T>(location, extra: extra).whenComplete(() => onResume());
  }

  void pushReplacement(String location, {Object? extra}) {
    return context.pushReplacement(location, extra: extra);
  }

  void openDialog({
    required Widget Function(BuildContext context) builder,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    bool overlap = false,
  }) {
    ref.read(navigatorServiceProvider).openDialog(
          builder: builder,
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor,
          barrierLabel: barrierLabel,
          useSafeArea: useSafeArea,
          useRootNavigator: useRootNavigator,
          routeSettings: routeSettings,
          anchorPoint: anchorPoint,
          overlap: overlap,
        );
  }

  void openBottomSheet({
    required Widget Function(BuildContext context) builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool useSafeArea = false,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
  }) {
    ref.read(navigatorServiceProvider).openBottomSheet(
          builder: builder,
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: shape,
          clipBehavior: clipBehavior,
          constraints: constraints,
          barrierColor: barrierColor,
          isScrollControlled: isScrollControlled,
          useRootNavigator: useRootNavigator,
          isDismissible: isDismissible,
          enableDrag: enableDrag,
          useSafeArea: useSafeArea,
          routeSettings: routeSettings,
          transitionAnimationController: transitionAnimationController,
          anchorPoint: anchorPoint,
        );
  }

  ///***************************************************************************
  /// COMMON
  ///***************************************************************************

  void clearFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void showSnackBar({
    required String message,
    required AppSnackBarType type,
    Duration duration = const Duration(seconds: 2),
    String? actionLabel,
    dynamic Function()? onActionPressed,
  }) {
    ref.read(messengerServiceProvider).showSnackBar(
          context,
          message: message,
          type: type,
          actionLabel: actionLabel,
          duration: duration,
          onActionPressed: onActionPressed,
        );
  }

  void showSuccessMessage(message) {
    showSnackBar(message: message, type: AppSnackBarType.success);
  }

  void showErrorMessage(message) {
    showSnackBar(message: message, type: AppSnackBarType.error);
  }

  void showHelpMessage(message) {
    showSnackBar(message: message, type: AppSnackBarType.help);
  }
}
