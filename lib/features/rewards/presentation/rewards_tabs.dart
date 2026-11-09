import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import 'rewards_style.dart';

class RewardsTabs extends StatelessWidget {
  const RewardsTabs({super.key, required this.gift, required this.onChanged});
  final bool gift;
  final ValueChanged<bool> onChanged;

  static const _gap = AppSpacing.sm;
  static const _shape = StadiumBorder(
    side: BorderSide(color: AppColors.white, width: 2),
  );

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return SizedBox(
      height: 46,
      child: LayoutBuilder(
        builder: (context, space) {
          final available = space.maxWidth - _gap;
          final earnWidth = available * .72;
          final giftWidth = available - earnWidth;
          return Stack(
            fit: StackFit.expand,
            children: [
              Row(
                children: [
                  _track(earnWidth),
                  const SizedBox(width: _gap),
                  _track(giftWidth),
                ],
              ),
              AnimatedPositioned(
                key: const Key('rewardsTabIndicator'),
                duration: AppMotion.duration(context, AppMotion.step),
                curve: AppMotion.curve,
                left: gift ? earnWidth + _gap : 0,
                width: gift ? giftWidth : earnWidth,
                top: 0,
                bottom: 0,
                child: const DecoratedBox(
                  decoration: ShapeDecoration(
                    color: AppColors.sky,
                    shape: _shape,
                  ),
                ),
              ),
              Row(
                children: [
                  _tab(strings.earnTab, earnWidth, isGift: false),
                  const SizedBox(width: _gap),
                  _tab(strings.giftTab, giftWidth, isGift: true),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _track(double width) => SizedBox(
    width: width,
    height: double.infinity,
    child: const DecoratedBox(
      decoration: ShapeDecoration(
        color: AppColors.catalogSurface,
        shape: _shape,
      ),
    ),
  );

  Widget _tab(String text, double width, {required bool isGift}) {
    final selected = gift == isGift;
    return SizedBox(
      width: width,
      height: double.infinity,
      child: Semantics(
        button: true,
        selected: selected,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: () => onChanged(isGift),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    text,
                    maxLines: 1,
                    style: TextStyle(
                      color: selected ? AppColors.white : AppColors.ink,
                      fontSize: RewardsTextSize.label,
                      fontWeight: selected
                          ? AppTypography.strongWeight
                          : AppTypography.labelWeight,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
