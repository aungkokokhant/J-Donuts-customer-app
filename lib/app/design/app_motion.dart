import 'package:flutter/material.dart';

abstract final class AppMotion {
  static const quick = Duration(milliseconds: 160);
  static const step = Duration(milliseconds: 280);
  static const entrance = Duration(milliseconds: 460);
  static const stagger = Duration(milliseconds: 85);
  static const carouselInterval = Duration(seconds: 5);
  static const shimmer = Duration(milliseconds: 1100);
  static const shake = Duration(milliseconds: 390);
  static const curve = Curves.easeOutCubic;

  static Duration duration(BuildContext context, Duration normal) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : normal;
}

class EnterMotion extends StatelessWidget {
  const EnterMotion({super.key, required this.child, this.index = 0});

  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return child;
    final delay = AppMotion.stagger * index;
    final duration = AppMotion.entrance + delay;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: Interval(delay.inMilliseconds / duration.inMilliseconds, 1),
      child: child,
      builder: (context, value, child) {
        final eased = AppMotion.curve.transform(value);
        return Opacity(
          opacity: eased,
          child: Transform.translate(
            offset: Offset(0, 22 * (1 - eased)),
            child: child,
          ),
        );
      },
    );
  }
}
