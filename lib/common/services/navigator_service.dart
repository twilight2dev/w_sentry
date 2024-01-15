import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/data/source/remote/exceptions/api_exception.dart';
import 'package:w_sentry/presentation/app_router.dart';
import 'package:w_sentry/presentation/shared_providers/auth/auth_viewmodel.dart';
import 'package:w_sentry/presentation/shared_widgets/bottom_sheet/bottom_sheet_handle_bar.dart';
import 'package:w_sentry/presentation/shared_widgets/dialog/confirmation_dialog.dart';

final navigatorServiceProvider = Provider<NavigatorService>((ref) => NavigatorService(ref));

class NavigatorService {
  final Ref ref;

  NavigatorService(this.ref);

  GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  bool isDialogOpen = false;
  bool isBottomSheetOpen = false;

  NavigatorState? get navigatorState => key.currentState;
  BuildContext? get context => key.currentContext;

  void back<T extends Object?>([T? result]) {
    return navigatorState?.pop<T>(result);
  }

  Future<T?> openDialog<T>({
    required Widget Function(BuildContext context) builder,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    bool overlap = false,
  }) async {
    if (context != null) {
      if (overlap == false && isDialogOpen) {
        return null;
      }
      isDialogOpen = true;
      return showDialog<T>(
        context: context!,
        builder: builder,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        barrierColor: barrierColor,
        useSafeArea: useSafeArea,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        anchorPoint: anchorPoint,
      ).whenComplete(() {
        isDialogOpen = false;
      });
    }
    return null;
  }

  Future<T?> openBottomSheet<T>({
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
  }) async {
    if (context != null) {
      isBottomSheetOpen = true;
      return showModalBottomSheet<T>(
        context: context!,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              const BottomSheetHandleBar(),
              const SizedBox(height: 10),
              builder(context),
            ],
          );
        },
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
        clipBehavior: clipBehavior,
        constraints: constraints,
        barrierColor: barrierColor,
        isScrollControlled: isScrollControlled,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        useSafeArea: useSafeArea,
        routeSettings: routeSettings,
        transitionAnimationController: transitionAnimationController,
        anchorPoint: anchorPoint,
      ).whenComplete(() {
        isBottomSheetOpen = false;
      });
    }
    return null;
  }

  void showErrorDialog(ApiException exception) {
    final isAuthException = exception is UnauthorizedException;
    openDialog(
      overlap: false,
      barrierDismissible: !isAuthException,
      builder: (context) {
        return ConfirmationDialog(
          title: 'Something went wrong.',
          content: Text(exception.errorMessage),
          confirmLabel: isAuthException ? 'Logout' : 'Okay',
          onConfirm: () {
            if (isAuthException) {
              ref.read(authVMProvider.notifier).logout();
              ref.read(routerProvider).go(AppScreens.login.path);
            }
          },
        );
      },
    );
  }
}
