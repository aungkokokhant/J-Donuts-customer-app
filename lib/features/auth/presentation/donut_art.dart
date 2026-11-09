import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';

class DonutArt extends StatelessWidget {
  const DonutArt({super.key, required this.height, this.tiles = false});

  final double height;
  final bool tiles;

  @override
  Widget build(BuildContext context) {
    final total = AppMotion.entrance + AppMotion.stagger * 4;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (bounds) => const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.white, AppColors.white, Colors.transparent],
          stops: [0, .78, 1],
        ).createShader(bounds),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: AppMotion.duration(context, total),
          builder: (context, value, _) =>
              CustomPaint(painter: _DonutPainter(value, tiles: tiles)),
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter(this.progress, {required this.tiles});

  final double progress;
  final bool tiles;

  static const _dough = Color(0xFFB66B36);
  static const _strawberry = Color(0xFFFF77A9);
  static const _raspberry = Color(0xFFD74283);
  static const _purple = Color(0xFF9C74E6);
  static const _chocolate = Color(0xFF763C36);
  static const _gold = Color(0xFFFFD08C);
  static const _peach = Color(0xFFF9DAD0);
  static const _lavender = Color(0xFFDCD7FA);
  static const _blue = Color(0xFFC5EAF8);
  static const _sprinkles = [
    AppColors.white,
    AppColors.sky,
    _chocolate,
    _gold,
    _purple,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    canvas.clipRect(Offset.zero & size);
    if (tiles) {
      final radius = math.min(w * .23, h * .22);
      _tile(canvas, Offset(w * .24, h * .26), radius, _blue, _purple, 0);
      _tile(canvas, Offset(w * .76, h * .34), radius, _lavender, _chocolate, 1);
      _tile(canvas, Offset(w * .24, h * .73), radius, _peach, _strawberry, 2);
      _tile(canvas, Offset(w * .76, h * .81), radius, _gold, _raspberry, 3);
      return;
    }
    final radius = math.min(w * .28, h * .26);
    _tile(canvas, Offset(-w * .07, h * .09), radius * .91, _blue, _purple, 0);
    _tile(canvas, Offset(w * .53, h * .43), radius, _peach, _strawberry, 1);
    _tile(
      canvas,
      Offset(w * 1.07, h * .11),
      radius * .9,
      _lavender,
      _chocolate,
      2,
    );
    _tile(canvas, Offset(w * 1.09, h * .72), radius, _blue, _raspberry, 3);
    _tile(canvas, Offset(w * .51, h * 1.03), radius, _gold, _purple, 4);
  }

  void _tile(
    Canvas canvas,
    Offset restingCenter,
    double radius,
    Color bg,
    Color icing,
    int index,
  ) {
    final delay = AppMotion.stagger.inMilliseconds * index;
    final elapsed =
        progress * (AppMotion.entrance + AppMotion.stagger * 4).inMilliseconds;
    final phase = ((elapsed - delay) / AppMotion.entrance.inMilliseconds).clamp(
      0.0,
      1.0,
    );
    if (phase == 0) return;
    final remaining = 1 - AppMotion.curve.transform(phase);
    final center = restingCenter.translate(
      (index.isEven ? -1 : 1) * 42 * remaining,
      26 * remaining,
    );
    final paint = Paint()..color = bg;
    if (tiles) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCircle(center: center, radius: radius),
          const Radius.circular(20),
        ),
        paint,
      );
    } else {
      canvas.drawCircle(center, radius, paint);
    }
    final donut = center.translate(0, -3);
    final outer = radius * .66;
    final inner = outer * .36;
    final dough = _ring(donut.translate(0, 5), outer, inner);
    canvas.drawShadow(dough, _chocolate, 7, false);
    canvas.drawPath(dough, Paint()..color = _dough);
    final glaze = _ring(donut, outer * .95, inner * 1.12);
    canvas.drawPath(
      glaze,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.lerp(icing, AppColors.white, .22)!, icing],
        ).createShader(Rect.fromCircle(center: donut, radius: outer)),
    );
    _scatter(canvas, donut, outer);
  }

  Path _ring(Offset center, double outer, double inner) => Path()
    ..fillType = PathFillType.evenOdd
    ..addOval(Rect.fromCircle(center: center, radius: outer))
    ..addOval(Rect.fromCircle(center: center, radius: inner));

  void _scatter(Canvas canvas, Offset center, double radius) {
    final random = math.Random(51);
    final paint = Paint()
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round;
    for (var index = 0; index < 29; index++) {
      final angle = index * math.pi * 2 / 29;
      final distance = radius * (.52 + random.nextDouble() * .33);
      final start =
          center + Offset(math.cos(angle), math.sin(angle)) * distance;
      final direction = angle + random.nextDouble() * 3;
      final end = start + Offset(math.cos(direction), math.sin(direction)) * 5;
      canvas.drawLine(
        start,
        end,
        paint..color = _sprinkles[index % _sprinkles.length],
      );
    }
  }

  @override
  bool shouldRepaint(_DonutPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.tiles != tiles;
}
