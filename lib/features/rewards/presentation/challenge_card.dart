import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/presentation/catalog_image.dart';
import '../../../core/presentation/catalog_price.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/rewards_repository.dart';
import 'rewards_style.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({super.key, required this.challenge});
  final RewardChallenge challenge;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final theme = Theme.of(context).textTheme;
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md + AppSpacing.xs),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: FractionallySizedBox(
                widthFactor: .89,
                child: _ChallengeArt(challenge: challenge),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    challenge.title,
                    style: theme.titleMedium?.copyWith(
                      fontSize: RewardsTextSize.challengeTitle,
                      fontWeight: AppTypography.strongWeight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    strings.challengeProgress(
                      challenge.completed,
                      challenge.target,
                    ),
                    style: theme.bodyMedium?.copyWith(
                      fontSize: RewardsTextSize.challengeDetail,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.xs,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _EarnButton(
                        active: challenge.completed >= challenge.target,
                        label: strings.earn,
                      ),
                      Text(
                        strings.rewardPoints(
                          formatNumber(context, challenge.points),
                        ),
                        style: theme.bodyMedium?.copyWith(
                          fontSize: RewardsTextSize.challengeDetail,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EarnButton extends StatelessWidget {
  const _EarnButton({required this.active, required this.label});
  final bool active;
  final String label;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: const Size(72, 49),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.rewardInactive,
        disabledForegroundColor: AppColors.white,
      ),
      onPressed: active ? () {} : null,
      child: Text(label.toUpperCase()),
    );
    if (!active || MediaQuery.disableAnimationsOf(context)) return button;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: AppMotion.rewardPulse,
      builder: (_, value, child) => Transform.scale(
        scale: 1 + math.sin(math.pi * value) * .10,
        child: child,
      ),
      child: button,
    );
  }
}

class _ChallengeArt extends StatelessWidget {
  const _ChallengeArt({required this.challenge});
  final RewardChallenge challenge;

  static const _frosted = ColorFilter.matrix(<double>[
    .0680,
    .2289,
    .0231,
    0,
    166,
    .0680,
    .2289,
    .0231,
    0,
    166,
    .0680,
    .2289,
    .0231,
    0,
    166,
    0,
    0,
    0,
    1,
    0,
  ]);

  @override
  Widget build(BuildContext context) {
    final image = CatalogImage(source: challenge.imageKey);
    final isDonut = challenge.kind == ChallengeKind.donut;
    final background = isDonut
        ? RepaintBoundary(
            child: ColorFiltered(colorFilter: _frosted, child: image),
          )
        : Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: .74,
              heightFactor: .74,
              child: image,
            ),
          );
    return AspectRatio(
      aspectRatio: 1,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: challenge.completed / challenge.target),
        duration: AppMotion.duration(context, AppMotion.rewardEntrance),
        curve: AppMotion.curve,
        child: background,
        builder: (context, value, background) => Stack(
          fit: StackFit.expand,
          children: [
            if (!isDonut || value < 1) background!,
            if (isDonut)
              ClipPath(
                key: const ValueKey('coloredDonut'),
                clipper: value < 1 ? _DonutSector(value) : null,
                clipBehavior: value < 1 ? Clip.antiAlias : Clip.none,
                child: image,
              )
            else
              CustomPaint(painter: _CoffeeProgress(value)),
          ],
        ),
      ),
    );
  }
}

class _DonutSector extends CustomClipper<Path> {
  const _DonutSector(this.fill);
  final double fill;

  @override
  Path getClip(Size size) {
    final center = size.center(Offset.zero);
    return Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: size.longestSide),
        -math.pi / 2,
        math.pi * 2 * fill,
        false,
      )
      ..close();
  }

  @override
  bool shouldReclip(_DonutSector oldClipper) => fill != oldClipper.fill;
}

class _CoffeeProgress extends CustomPainter {
  const _CoffeeProgress(this.fill);
  final double fill;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * .60);
    final ring = Rect.fromCircle(
      center: center,
      radius: size.shortestSide * .43,
    );
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.shortestSide * .087
      ..color = AppColors.catalogSurface;
    canvas.drawArc(ring, math.pi, math.pi, false, paint);
    if (fill > 0) {
      canvas.drawArc(
        ring,
        math.pi,
        math.pi * fill,
        false,
        paint..color = AppColors.orange,
      );
    }
  }

  @override
  bool shouldRepaint(_CoffeeProgress oldDelegate) => fill != oldDelegate.fill;
}
