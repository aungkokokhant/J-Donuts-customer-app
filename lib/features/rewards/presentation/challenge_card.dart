import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/presentation/catalog_image.dart';
import '../../../core/presentation/catalog_price.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/rewards_repository.dart';

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
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(flex: 5, child: _ChallengeArt(challenge: challenge)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    challenge.title,
                    style: theme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    strings.challengeProgress(
                      challenge.completed,
                      challenge.target,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
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
        minimumSize: const Size(70, 40),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        disabledBackgroundColor: AppColors.skeleton,
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

  static const _gray = ColorFilter.matrix(<double>[
    .2126,
    .7152,
    .0722,
    0,
    0,
    .2126,
    .7152,
    .0722,
    0,
    0,
    .2126,
    .7152,
    .0722,
    0,
    0,
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
    return AspectRatio(
      aspectRatio: 1,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: challenge.completed / challenge.target),
        duration: AppMotion.duration(context, AppMotion.rewardEntrance),
        curve: AppMotion.curve,
        builder: (context, value, _) => Stack(
          fit: StackFit.expand,
          children: [
            if (isDonut) ...[
              ColorFiltered(colorFilter: _gray, child: image),
              ClipPath(clipper: _DonutSector(value), child: image),
            ] else
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSpacing.sm,
                  bottom: AppSpacing.xs,
                ),
                child: image,
              ),
            CustomPaint(painter: _ChallengeProgress(value, donut: isDonut)),
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
    if (fill >= 1) return Path()..addRect(Offset.zero & size);
    final center = Offset(size.width / 2, size.height * .48);
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

class _ChallengeProgress extends CustomPainter {
  const _ChallengeProgress(this.fill, {required this.donut});
  final double fill;
  final bool donut;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * (donut ? .48 : .63));
    final ring = Rect.fromCircle(
      center: center,
      radius: size.shortestSide * (donut ? .34 : .43),
    );
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = donut ? 2 : 5
      ..color = AppColors.catalogSurface;
    final start = donut ? -math.pi / 2 : math.pi;
    final turn = donut ? math.pi * 2 : math.pi;
    canvas.drawArc(ring, start, turn, false, paint);
    if (fill > 0) {
      canvas.drawArc(
        ring,
        start,
        turn * fill,
        false,
        paint..color = donut ? AppColors.pink : AppColors.orange,
      );
    }
  }

  @override
  bool shouldRepaint(_ChallengeProgress oldDelegate) =>
      fill != oldDelegate.fill || donut != oldDelegate.donut;
}
