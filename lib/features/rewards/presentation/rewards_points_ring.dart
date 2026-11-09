import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/design/app_theme.dart';
import '../../../core/presentation/catalog_price.dart';
import '../../../l10n/app_localizations.dart';
import 'rewards_style.dart';

class RewardsPointsRing extends StatelessWidget {
  const RewardsPointsRing({
    super.key,
    required this.points,
    required this.fill,
  });

  final int points;
  final double fill;

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: RepaintBoundary(
            child: CustomPaint(painter: _PointsPainter(fill)),
          ),
        ),
        FractionallySizedBox(
          widthFactor: .52,
          child: FittedBox(fit: BoxFit.scaleDown, child: _total(context)),
        ),
      ],
    ),
  );

  Widget _total(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context).totalPoints,
          style: theme.titleSmall?.copyWith(
            color: AppColors.pink,
            fontSize: RewardsTextSize.label,
            fontWeight: AppTypography.strongWeight,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          formatNumber(context, points),
          key: const Key('rewardPointTotal'),
          style: theme.headlineMedium?.copyWith(
            color: AppColors.pink,
            fontSize: RewardsTextSize.points,
            fontWeight: FontWeight.w900,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}

class _PointsPainter extends CustomPainter {
  const _PointsPainter(this.fill);

  final double fill;
  static const _start = -math.pi / 2 + .14;
  static const _turn = math.pi * 2;
  static const _sprinkleCount = 24;
  static const _icing = RadialGradient(
    colors: [
      AppColors.rewardShadow,
      AppColors.pink,
      AppColors.rewardHighlight,
      AppColors.pink,
      AppColors.rewardShadow,
    ],
    stops: [.55, .61, .76, .94, 1],
  );

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.shortestSide * .21;
    final outer = size.shortestSide / 2 - 1;
    final center = size.center(Offset.zero);
    final radius = outer - width / 2;
    if (radius <= 0) return;
    final ring = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..color = AppColors.catalogSurface;
    canvas.drawCircle(center, radius, paint);
    if (fill <= 0) return;
    paint
      ..strokeCap = StrokeCap.round
      ..shader = _icing.createShader(
        Rect.fromCircle(center: center, radius: outer),
      );
    canvas.drawArc(ring, _start, _turn * fill, false, paint);
    _sprinkles(canvas, center, radius, width);
  }

  void _sprinkles(Canvas canvas, Offset center, double radius, double width) {
    final paint = Paint()
      ..color = AppColors.white.withValues(alpha: .32)
      ..strokeWidth = width * .105
      ..strokeCap = StrokeCap.round;
    for (var index = 0; index < _sprinkleCount; index++) {
      final position = (index + .40) / _sprinkleCount;
      if (position > fill) break;
      final angle = _start + _turn * position;
      final inset = ((index % 3) - 1) * width * .24;
      final anchor = center + _direction(angle) * (radius + inset);
      final tilt = angle + (index.isEven ? .6 : 1.6);
      final span = _direction(tilt) * width * .16;
      canvas.drawLine(anchor - span, anchor + span, paint);
    }
  }

  Offset _direction(double angle) => Offset(math.cos(angle), math.sin(angle));

  @override
  bool shouldRepaint(_PointsPainter oldDelegate) => oldDelegate.fill != fill;
}
