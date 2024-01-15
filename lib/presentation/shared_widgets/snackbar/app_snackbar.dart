import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:w_sentry/common/extensions/text_style_ext.dart';
import 'package:w_sentry/presentation/shared_widgets/snackbar/app_snackbar_type.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_dimens.dart';
import 'package:w_sentry/res/app_typography.dart';

class AppSnackbarOverlay {
  AppSnackbarOverlay({required this.id});

  final int id;
  late final OverlayEntry overlayEntry;
}

class AppSnackBarContent extends StatefulWidget {
  const AppSnackBarContent({
    super.key,
    required this.message,
    required this.onClosed,
    required this.snackbarOverlay,
    required this.type,
    this.actionLabel,
    this.actionOnPressed,
    this.duration = const Duration(seconds: 2),
  });

  final String? actionLabel;
  final Function()? actionOnPressed;
  final Duration duration;
  final Function(AppSnackbarOverlay snackbarOverlay) onClosed;
  final AppSnackbarOverlay snackbarOverlay;
  final AppSnackBarType type;
  final String message;

  @override
  State<AppSnackBarContent> createState() => _AppSnackBarContentState();
}

class _AppSnackBarContentState extends State<AppSnackBarContent> {
  bool _showsSnackbar = false;
  bool _hasShownSnackbar = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 10)).whenComplete(() {
      setState(() => _showsSnackbar = true);
      Future.delayed(widget.duration).whenComplete(() {
        if (_showsSnackbar) _hideSnackbar();
      });
    });
  }

  void _hideSnackbar() {
    if (mounted) {
      setState(() => _showsSnackbar = false);
    }
    _hasShownSnackbar = true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: 0,
      right: 0,
      top: _showsSnackbar ? 0 : -140,
      bottom: null,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      onEnd: () {
        if (_hasShownSnackbar) {
          widget.onClosed.call(widget.snackbarOverlay);
        }
      },
      child: Material(
        color: Colors.transparent,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    final paddingTop = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onVerticalDragEnd: (_) => _hideSnackbar(),
      child: Container(
        padding: EdgeInsets.fromLTRB(16, paddingTop + 16, 16, 12),
        decoration: BoxDecoration(color: widget.type.backgroundColor),
        child: Row(
          children: [
            Icon(widget.type.icon, size: 24, color: AppColors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.message,
                style: AppTypography.poppins_14px_w500.withColor(AppColors.white),
              ),
            ),
            if (widget.actionLabel != null) ...[
              const SizedBox(width: 8),
              CupertinoButton(
                minSize: 0,
                padding: const EdgeInsets.symmetric(horizontal: PaddingDefault.small, vertical: 2),
                color: Colors.transparent,
                child: Text(
                  widget.actionLabel!,
                  style: AppTypography.poppins_14px_w600,
                ),
                onPressed: () {
                  widget.actionOnPressed?.call();
                },
              )
            ]
          ],
        ),
      ),
    );
  }
}
