import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/domain/member_profile.dart';
import '../../../core/presentation/catalog_price.dart';
import '../../../l10n/app_localizations.dart';

class RewardsOverview extends StatelessWidget {
  const RewardsOverview({super.key, required this.member});
  final MemberProfile member;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: 1),
    duration: AppMotion.duration(context, AppMotion.rewardEntrance),
    curve: AppMotion.curve,
    builder: (context, progress, _) => LayoutBuilder(
      builder: (context, space) {
        final ladder = _TierLadder(member: member, progress: progress);
        final ring = _PointsRing(
          points: (member.totalPoints * progress).round(),
          fill: member.tierProgress * progress,
        );
        final scaled = MediaQuery.textScalerOf(context).scale(16);
        if (space.maxWidth < 310 && scaled > 19) {
          return Column(
            children: [
              SizedBox(width: 190, child: ring),
              const SizedBox(height: AppSpacing.md),
              ladder,
            ],
          );
        }
        return Row(
          children: [
            Expanded(flex: 4, child: ladder),
            const SizedBox(width: AppSpacing.sm),
            Expanded(flex: 5, child: ring),
          ],
        );
      },
    ),
  );
}

enum _Tier {
  silver('S', AppColors.medalSilver),
  gold('G', AppColors.medalGold),
  platinum('P', AppColors.medalPlatinum);

  const _Tier(this.initial, this.color);
  final String initial;
  final Color color;

  String label(AppLocalizations strings) => switch (this) {
    silver => strings.silver,
    gold => strings.gold,
    platinum => strings.platinum,
  };
}

class _TierLadder extends StatelessWidget {
  const _TierLadder({required this.member, required this.progress});
  final MemberProfile member;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final currentIndex = _Tier.values.indexWhere(
      (tier) => tier.name == member.tier.toLowerCase(),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final tier in _Tier.values)
          EnterMotion(
            index: tier.index,
            child: _TierStep(
              tier: tier,
              title: tier.label(strings),
              subtitle: _subtitle(context, strings, tier),
              current: tier.index == currentIndex,
              lineFill: tier.index < currentIndex
                  ? 1
                  : tier.index == currentIndex
                  ? member.tierProgress * progress
                  : 0,
            ),
          ),
      ],
    );
  }

  String _subtitle(BuildContext context, AppLocalizations strings, _Tier tier) {
    if (member.tier.toLowerCase() == tier.name) return strings.currentTier;
    if (member.nextTier.toLowerCase() == tier.name) {
      return strings.nextTierRemaining(
        formatNumber(context, member.pointsToNextTier),
        tier.label(strings),
      );
    }
    return strings.futureTier;
  }
}

class _TierStep extends StatelessWidget {
  const _TierStep({
    required this.tier,
    required this.title,
    required this.subtitle,
    required this.current,
    required this.lineFill,
  });
  final _Tier tier;
  final String title;
  final String subtitle;
  final bool current;
  final double lineFill;

  static const _markerWidth = 34.0;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(minHeight: _markerWidth),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            _markerWidth + AppSpacing.sm,
            AppSpacing.xs,
            0,
            AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: current ? AppColors.pink : AppColors.ink,
                ),
              ),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
      Positioned(
        left: 0,
        top: 0,
        bottom: 0,
        width: _markerWidth,
        child: _TierMarker(tier: tier, lineFill: lineFill, current: current),
      ),
    ],
  );
}

class _TierMarker extends StatelessWidget {
  const _TierMarker({
    required this.tier,
    required this.lineFill,
    required this.current,
  });
  final _Tier tier;
  final double lineFill;
  final bool current;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 34,
    child: Column(
      children: [
        SizedBox.square(
          dimension: 34,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.shield_rounded, size: 34, color: tier.color),
              Text(
                tier.initial,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: current ? AppColors.ink : AppColors.muted,
                ),
              ),
            ],
          ),
        ),
        if (tier != _Tier.platinum)
          Expanded(
            child: SizedBox(
              width: 3,
              child: ColoredBox(
                color: AppColors.skeleton,
                child: FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: lineFill,
                  child: const ColoredBox(color: AppColors.pink),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

class _PointsRing extends StatelessWidget {
  const _PointsRing({required this.points, required this.fill});
  final int points;
  final double fill;

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(child: CustomPaint(painter: _PointsPainter(fill))),
        FractionallySizedBox(
          widthFactor: .60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context).totalPoints,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.pink,
                  fontWeight: FontWeight.w800,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  formatNumber(context, points),
                  key: const Key('rewardPointTotal'),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.pink,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _PointsPainter extends CustomPainter {
  const _PointsPainter(this.fill);
  final double fill;

  static const _start = -math.pi / 2;
  static const _turn = math.pi * 2;
  static const _sprinkleCount = 27;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.shortestSide * .20;
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - width) / 2 - 1;
    if (radius <= 0) return;
    final ring = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    canvas.drawCircle(center, radius, paint..color = AppColors.catalogSurface);
    if (fill <= 0) return;
    paint.strokeCap = StrokeCap.round;
    paint.shader = const SweepGradient(
      colors: [
        AppColors.pink,
        AppColors.rewardShadow,
        AppColors.rewardHighlight,
        AppColors.pink,
      ],
      transform: GradientRotation(_start),
    ).createShader(ring);
    canvas.drawArc(ring, _start, _turn * fill, false, paint);
    _sprinkles(canvas, center, radius, width);
  }

  void _sprinkles(Canvas canvas, Offset center, double radius, double width) {
    final paint = Paint()
      ..color = AppColors.rewardHighlight
      ..strokeWidth = math.max(1.5, width * .12)
      ..strokeCap = StrokeCap.round;
    for (var index = 0; index < _sprinkleCount; index++) {
      final position = (index + .35) / _sprinkleCount;
      if (position > fill) break;
      final angle = _start + _turn * position;
      final inset = ((index % 3) - 1) * width * .23;
      final from =
          center + Offset(math.cos(angle), math.sin(angle)) * (radius + inset);
      final direction = angle + (index.isEven ? .82 : 1.48);
      final to =
          from + Offset(math.cos(direction), math.sin(direction)) * width * .30;
      canvas.drawLine(from, to, paint);
    }
  }

  @override
  bool shouldRepaint(_PointsPainter oldDelegate) => oldDelegate.fill != fill;
}
