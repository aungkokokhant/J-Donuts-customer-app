import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.blush, AppColors.canvas, AppColors.blush],
        ),
      ),
      child: SafeArea(child: child),
    ),
  );
}

class AuthLegal extends StatelessWidget {
  const AuthLegal({super.key});

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
      style: const TextStyle(fontSize: 12, height: 1.4, color: AppColors.muted),
    );
  }

  WidgetSpan _link(BuildContext context, String label) => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: GestureDetector(
      onTap: () => showAuthPlaceholder(context),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.pink,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

void showAuthPlaceholder(BuildContext context) => ScaffoldMessenger.of(context)
    .showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).notAvailable)),
    );

class AuthButton extends StatefulWidget {
  const AuthButton({
    super.key,
    required this.label,
    this.onPressed,
    this.busy = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool busy;

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null && !widget.busy;
    final duration = AppMotion.duration(context, AppMotion.quick);
    return Listener(
      onPointerDown: enabled ? (_) => setState(() => _pressed = true) : null,
      onPointerUp: (_) => setState(() => _pressed = false),
      onPointerCancel: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        duration: duration,
        scale: _pressed && enabled && duration != Duration.zero ? .97 : 1,
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: enabled ? widget.onPressed : null,
            child: AnimatedSwitcher(
              duration: duration,
              child: widget.busy
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(widget.label.toUpperCase()),
            ),
          ),
        ),
      ),
    );
  }
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
      child: SizedBox.square(
        dimension: 28,
        child: value >= 1
            ? const Icon(Icons.check, size: 16, color: AppColors.white)
            : null,
      ),
    ),
  );
}

class _RingPainter extends CustomPainter {
  const _RingPainter(this.progress);
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 3;
    final paint = Paint()
      ..color = AppColors.pink
      ..strokeWidth = 4;
    if (progress >= 1) {
      canvas.drawCircle(center, radius + 2, paint);
      return;
    }
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paint..color = AppColors.sky);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      paint..color = AppColors.pink,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
