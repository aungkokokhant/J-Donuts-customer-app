import 'package:flutter/material.dart';

import '../../../app/design/app_theme.dart';

enum DonutBackdropStyle {
  aqua(AppColors.artAqua, AppColors.artAquaDeep),
  peach(AppColors.artPeach, AppColors.artPetal),
  ice(AppColors.artIce, AppColors.artPetal),
  sky(AppColors.artPowderBlue, AppColors.artSkyShade),
  mint(AppColors.artSkyShade, AppColors.artMint),
  honey(AppColors.artHoney, AppColors.artHoneyLight);

  const DonutBackdropStyle(this.base, this.accent);

  final Color base;
  final Color accent;
}

class DonutBackdrop extends StatelessWidget {
  const DonutBackdrop({super.key, required this.style, this.borderRadius});

  final DonutBackdropStyle style;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final pattern = CustomPaint(painter: _BackdropPainter(style));
    final radius = borderRadius;
    return radius == null
        ? ClipOval(child: pattern)
        : ClipRRect(borderRadius: radius, child: pattern);
  }
}

class _BackdropPainter extends CustomPainter {
  const _BackdropPainter(this.style);

  final DonutBackdropStyle style;
  static const _bounds = Rect.fromLTWH(0, 0, 1, 1);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width, size.height);
    canvas.drawRect(
      _bounds,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            style.base,
            Color.lerp(style.base, AppColors.landingPink, .25)!,
          ],
        ).createShader(_bounds),
    );
    switch (style) {
      case DonutBackdropStyle.aqua:
        _stripe(canvas, const Offset(.2, -.1), const Offset(1.1, .87), .18);
        _stripe(canvas, const Offset(.46, -.1), const Offset(1.12, .61), .08);
      case DonutBackdropStyle.peach:
        _ribbon(canvas, const Offset(0, .60), const Offset(1, .88));
        _sprinkles(canvas);
      case DonutBackdropStyle.ice:
        _ribbon(canvas, const Offset(0, .81), const Offset(1, .35), alpha: .48);
        _dots(canvas);
      case DonutBackdropStyle.sky:
        _ribbon(
          canvas,
          const Offset(0, .32),
          const Offset(1, -.53),
          alpha: .42,
        );
        _stripe(canvas, const Offset(.29, .82), const Offset(.92, .39), .055);
        _stripe(canvas, const Offset(.68, .91), const Offset(.76, .98), .035);
      case DonutBackdropStyle.mint:
        _stripe(canvas, const Offset(-.1, .58), const Offset(.59, 1.04), .09);
        _stripe(canvas, const Offset(-.1, .42), const Offset(.69, .97), .045);
        _dots(canvas);
      case DonutBackdropStyle.honey:
        _stripe(canvas, const Offset(.51, .49), const Offset(.05, -.08), .10);
        _stripe(canvas, const Offset(.51, .49), const Offset(.61, -.08), .095);
        _stripe(canvas, const Offset(.51, .49), const Offset(.97, .01), .07);
    }
    canvas.restore();
  }

  void _ribbon(Canvas canvas, Offset left, Offset right, {double alpha = .85}) {
    final ribbon = Path()
      ..moveTo(left.dx, left.dy)
      ..lineTo(right.dx, right.dy)
      ..lineTo(1, 1)
      ..lineTo(0, 1)
      ..close();
    canvas.drawPath(
      ribbon,
      Paint()..color = style.accent.withValues(alpha: alpha),
    );
  }

  void _stripe(
    Canvas canvas,
    Offset from,
    Offset to,
    double width, {
    double alpha = .65,
  }) {
    canvas.drawLine(
      from,
      to,
      Paint()
        ..color = style.accent.withValues(alpha: alpha)
        ..strokeWidth = width,
    );
  }

  void _sprinkles(Canvas canvas) {
    _stripe(canvas, const Offset(.09, .37), const Offset(.25, .23), .031);
    _stripe(canvas, const Offset(.48, .14), const Offset(.52, .29), .029);
    _stripe(canvas, const Offset(.10, .69), const Offset(.17, .51), .03);
    _stripe(canvas, const Offset(.79, .71), const Offset(.83, .51), .029);
    _stripe(canvas, const Offset(.91, .26), const Offset(.98, .33), .032);
  }

  void _dots(Canvas canvas) {
    const points = [
      Offset(.13, .27),
      Offset(.19, .39),
      Offset(.22, .15),
      Offset(.24, .54),
      Offset(.30, .31),
      Offset(.34, .47),
      Offset(.35, .08),
      Offset(.41, .21),
      Offset(.55, .35),
      Offset(.59, .15),
      Offset(.72, .23),
      Offset(.81, .39),
    ];
    final paint = Paint()..color = AppColors.artMint.withValues(alpha: .55);
    for (final (index, point) in points.indexed) {
      canvas.drawCircle(point, index.isEven ? .012 : .007, paint);
    }
  }

  @override
  bool shouldRepaint(_BackdropPainter oldDelegate) =>
      oldDelegate.style != style;
}
