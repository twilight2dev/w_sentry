import 'package:flutter/widgets.dart';
import 'immediate_animation.dart';

/// Animates the offset relative to the [child] normal position immediately or
/// after the given [delay].
class ImmediateSlideAnimation extends ImmediateAnimation<Offset> {
  const ImmediateSlideAnimation({
    super.key,
    required super.child,
    required super.duration,
    super.begin = Offset.zero,
    super.end = Offset.zero,
    super.curve,
    super.delay,
  });

  @override
  ImmediateAnimationState<ImmediateAnimation<Offset>, Offset> createState() => _ImmediateSlideAnimationState();
}

class _ImmediateSlideAnimationState extends ImmediateAnimationState<ImmediateSlideAnimation, Offset> {
  @override
  ImplicitlyAnimatedWidget buildAnimated(Widget child, Offset value) {
    return AnimatedSlide(
      offset: value,
      duration: widget.duration,
      curve: widget.curve,
      child: widget.child,
    );
  }
}
