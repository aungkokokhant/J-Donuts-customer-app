import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/presentation/unavailable_message.dart';
import '../../../l10n/app_localizations.dart';

abstract final class AuthLayout {
  static const pageInset = 32.0;
  static const profileHeadingWidth = 245.0;
  static const fieldInset = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: 20,
  );

  static TextStyle? heading(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge?.copyWith(letterSpacing: -.35);
}

class AuthBackground extends StatelessWidget {
  const AuthBackground({
    super.key,
    required this.child,
    this.gradient = _authGradient,
    this.safeTop = true,
  });

  static const _authGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.blush, AppColors.canvas, AppColors.blush],
  );

  final Widget child;
  final Gradient gradient;
  final bool safeTop;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: gradient),
        child: SafeArea(top: safeTop, child: child),
      ),
    ),
  );
}

class AuthLegal extends StatelessWidget {
  const AuthLegal({super.key});

  static const _fontSize = 14.0;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '${strings.legalPrefix} '),
          _link(context, strings.terms),
          TextSpan(text: ' ${strings.andWord} '),
          _link(context, strings.privacy),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: _fontSize,
        height: 1.4,
        color: AppColors.muted,
        fontWeight: AppTypography.labelWeight,
      ),
    );
  }

  WidgetSpan _link(BuildContext context, String label) => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: GestureDetector(
      onTap: () => showUnavailableMessage(context),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: _fontSize,
          color: AppColors.pink,
          fontWeight: AppTypography.labelWeight,
        ),
      ),
    ),
  );
}

class RegistrationRing extends StatelessWidget {
  const RegistrationRing({super.key, required this.step});
  final int step;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: step / 4),
    duration: AppMotion.duration(context, AppMotion.step),
    curve: AppMotion.curve,
    builder: (context, value, child) => CustomPaint(
      painter: _RingPainter(value),
      child: const SizedBox.square(dimension: 30),
    ),
  );
}

class _RingPainter extends CustomPainter {
  const _RingPainter(this.progress);
  final double progress;
  static const _strokeWidth = 6.5;
  static const _edgeInset = 1.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outerRadius = size.shortestSide / 2 - _edgeInset;
    final radius = outerRadius - _strokeWidth / 2;
    final paint = Paint()
      ..color = AppColors.sky
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      paint..color = AppColors.pink,
    );
    final complete = ((progress - .90) / .10).clamp(0.0, 1.0);
    if (complete > 0) _drawCheck(canvas, center, outerRadius, complete);
  }

  void _drawCheck(Canvas canvas, Offset center, double radius, double phase) {
    canvas.drawCircle(center, radius * phase, Paint()..color = AppColors.pink);
    final check = Path()
      ..moveTo(center.dx - 5, center.dy)
      ..lineTo(center.dx - 1, center.dy + 4)
      ..lineTo(center.dx + 6, center.dy - 4);
    final metric = check.computeMetrics().single;
    canvas.drawPath(
      metric.extractPath(0, metric.length * phase),
      Paint()
        ..color = AppColors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
