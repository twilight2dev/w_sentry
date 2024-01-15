import 'package:flutter/material.dart';

class InfinityLoopFadeTransition extends StatefulWidget {
  const InfinityLoopFadeTransition({Key? key, this.duration, required this.child}) : super(key: key);

  final Widget child;
  final Duration? duration;

  @override
  State<InfinityLoopFadeTransition> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<InfinityLoopFadeTransition> with SingleTickerProviderStateMixin {
  late final AnimationController opacityController;
  late final Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    opacityController = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 1000),
    );
    opacityAnimation = Tween(begin: 1.0, end: 0.5).animate(opacityController);
    opacityController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        opacityController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        opacityController.forward();
      }
    });
    opacityController.forward();
  }

  @override
  void dispose() {
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityAnimation,
      child: widget.child,
    );
  }
}
