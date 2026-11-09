import 'package:flutter/material.dart';

import '../../../app/design/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import 'rewards_style.dart';

enum RewardTier {
  silver('S', AppColors.medalSilver, AppColors.medalSilverAccent),
  gold('G', AppColors.medalGold, AppColors.medalGoldAccent),
  platinum('P', AppColors.medalPlatinum, AppColors.sky);

  const RewardTier(this.initial, this.color, this.edge);
  final String initial;
  final Color color;
  final Color edge;

  String label(AppLocalizations strings) => switch (this) {
    silver => strings.silver,
    gold => strings.gold,
    platinum => strings.platinum,
  };
}

class RewardTierMedal extends StatelessWidget {
  const RewardTierMedal({super.key, required this.tier, required this.current});

  final RewardTier tier;
  final bool current;

  static const activeHeight = 50.0;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox(
      width: current ? 46 : 42,
      height: current ? activeHeight : 46,
      child: CustomPaint(
        painter: _MedalPainter(tier),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var star = 0; star <= tier.index; star++)
                  Icon(
                    Icons.star_rounded,
                    size: 9,
                    color: AppColors.muted.withValues(alpha: .70),
                  ),
              ],
            ),
            Text(
              tier.initial,
              textScaler: TextScaler.noScaling,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: RewardsTextSize.label,
                height: 1,
                fontWeight: FontWeight.w900,
                color: AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _MedalPainter extends CustomPainter {
  const _MedalPainter(this.tier);

  final RewardTier tier;
  static const _bounds = Rect.fromLTWH(0, 0, 1, 1);
  static final _shield = Path()
    ..moveTo(.39, .07)
    ..quadraticBezierTo(.50, .01, .61, .07)
    ..lineTo(.86, .20)
    ..quadraticBezierTo(.94, .24, .94, .34)
    ..lineTo(.94, .57)
    ..quadraticBezierTo(.94, .82, .59, .95)
    ..quadraticBezierTo(.50, .99, .41, .95)
    ..quadraticBezierTo(.06, .82, .06, .57)
    ..lineTo(.06, .34)
    ..quadraticBezierTo(.06, .24, .14, .20)
    ..close();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width, size.height);
    canvas.drawPath(
      _shield,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.white, tier.color, tier.edge],
        ).createShader(_bounds),
    );
    canvas.translate(.075, .065);
    canvas.scale(.85, .86);
    canvas.drawPath(
      _shield,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            tier.edge,
            tier.color,
            Color.lerp(tier.color, AppColors.white, .45)!,
          ],
        ).createShader(_bounds),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_MedalPainter oldDelegate) => oldDelegate.tier != tier;
}
