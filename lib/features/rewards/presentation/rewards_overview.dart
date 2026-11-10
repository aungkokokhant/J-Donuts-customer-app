import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/domain/member_profile.dart';
import '../../../core/presentation/catalog_price.dart';
import '../../../l10n/app_localizations.dart';
import 'rewards_points_ring.dart';
import 'rewards_style.dart';
import 'rewards_tier_medal.dart';

class RewardsOverview extends StatelessWidget {
  const RewardsOverview({super.key, required this.member});
  final MemberProfile member;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, space) {
      final width = space.maxWidth;
      final ring = RewardsPointsRing(
        points: member.totalPoints,
        fill: member.tierProgress,
      );
      final largeText = MediaQuery.textScalerOf(context).scale(16) > 19;
      return width <= 340 && largeText
          ? _stacked(width, ring)
          : _sideBySide(width, ring);
    },
  );

  Widget _stacked(double width, Widget ring) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
    child: Column(
      children: [
        SizedBox(width: width * .58, child: ring),
        const SizedBox(height: AppSpacing.md),
        _TierLadder(member: member, stepHeight: 68),
      ],
    ),
  );

  Widget _sideBySide(double width, Widget ring) {
    final ringSize = width * .59;
    return SizedBox(
      width: width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: -width * .08,
            child: SizedBox.square(dimension: ringSize, child: ring),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: ringSize),
            child: Padding(
              padding: EdgeInsets.only(left: width * .075),
              child: SizedBox(
                width: width * .405,
                child: _TierLadder(member: member, stepHeight: ringSize * .41),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TierLadder extends StatelessWidget {
  const _TierLadder({required this.member, required this.stepHeight});
  final MemberProfile member;
  final double stepHeight;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final currentIndex = RewardTier.values.indexWhere(
      (tier) => tier.name == member.tier.toLowerCase(),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final tier in RewardTier.values)
          EnterMotion(
            index: tier.index,
            child: _TierStep(
              tier: tier,
              title: tier.label(strings),
              subtitle: _subtitle(context, strings, tier),
              current: tier.index == currentIndex,
              stepHeight: tier == RewardTier.platinum
                  ? RewardTierMedal.activeHeight
                  : stepHeight,
              lineFill: tier.index < currentIndex
                  ? 1
                  : tier.index == currentIndex
                  ? member.tierProgress
                  : 0,
            ),
          ),
      ],
    );
  }

  String _subtitle(
    BuildContext context,
    AppLocalizations strings,
    RewardTier tier,
  ) {
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
    required this.stepHeight,
    required this.lineFill,
  });
  final RewardTier tier;
  final String title;
  final String subtitle;
  final bool current;
  final double stepHeight;
  final double lineFill;

  static const _markerWidth = 48.0;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(minHeight: stepHeight),
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
                  fontWeight: current
                      ? FontWeight.w900
                      : AppTypography.strongWeight,
                  fontSize: RewardsTextSize.title,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(fontSize: RewardsTextSize.body, height: 1.24),
              ),
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
  final RewardTier tier;
  final double lineFill;
  final bool current;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      RewardTierMedal(tier: tier, current: current),
      if (tier != RewardTier.platinum)
        Expanded(
          child: SizedBox(
            width: 3,
            child: ColoredBox(
              color: AppColors.skeleton,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: current ? 0 : lineFill, end: lineFill),
                duration: AppMotion.duration(context, AppMotion.rewardEntrance),
                curve: AppMotion.curve,
                child: const ColoredBox(color: AppColors.muted),
                builder: (_, fill, child) => FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: fill,
                  child: child,
                ),
              ),
            ),
          ),
        ),
    ],
  );
}
