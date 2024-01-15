import 'package:flutter/material.dart';
import 'package:w_sentry/common/extensions/text_style_ext.dart';
import 'package:w_sentry/presentation/shared_widgets/loading_widget.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_typography.dart';

class LoadingLayer extends StatelessWidget {
  const LoadingLayer({
    Key? key,
    required this.visible,
    required this.child,
    this.canPop = false,
    this.desc,
  }) : super(key: key);

  final bool visible;
  final bool canPop;
  final Widget child;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          child,
          if (visible)
            WillPopScope(
              onWillPop: () async => canPop,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const ModalBarrier(dismissible: false, color: Colors.black45),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LoadingWidget(size: 48),
                      if (desc != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          desc!,
                          style: AppTypography.poppins_14px_w500.withColor(AppColors.white),
                          textAlign: TextAlign.center,
                        ),
                      ]
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
