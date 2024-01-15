import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/presentation/shared_widgets/snackbar/app_snackbar.dart';
import 'package:w_sentry/presentation/shared_widgets/snackbar/app_snackbar_type.dart';

final messengerServiceProvider = Provider<MessengerService>((ref) => MessengerService());

class MessengerService {
  final GlobalKey<ScaffoldMessengerState> key = GlobalKey<ScaffoldMessengerState>();
  final List<AppSnackbarOverlay> _snackBarOverlays = [];

  void showBanner(MaterialBanner banner, {Duration duration = const Duration(seconds: 2)}) {
    if (key.currentState != null) {
      key.currentState!.hideCurrentMaterialBanner();
      key.currentState!.showMaterialBanner(banner);
      Future.delayed(
        duration,
        () => key.currentState!.hideCurrentMaterialBanner(),
      );
    }
  }

  void showSnackBar(
    BuildContext context, {
    required String message,
    required AppSnackBarType type,
    Duration duration = const Duration(seconds: 2),
    String? actionLabel,
    Function()? onActionPressed,
  }) {
    final overlayState = Overlay.of(context);
    final snackBarOverlay = AppSnackbarOverlay(id: _snackBarOverlays.length);
    snackBarOverlay.overlayEntry = OverlayEntry(builder: (context) {
      return AppSnackBarContent(
        message: message,
        type: type,
        onClosed: _removeOverlay,
        snackbarOverlay: snackBarOverlay,
        actionLabel: actionLabel,
        actionOnPressed: onActionPressed,
      );
    });
    _snackBarOverlays.add(snackBarOverlay);
    overlayState.insert(snackBarOverlay.overlayEntry);
  }

  void _removeOverlay(AppSnackbarOverlay snackBarOverlay) {
    snackBarOverlay.overlayEntry.remove();
    _snackBarOverlays.removeWhere((element) => element.id == snackBarOverlay.id);
  }
}
