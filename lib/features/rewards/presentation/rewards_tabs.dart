import 'package:flutter/material.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class RewardsTabs extends StatelessWidget {
  const RewardsTabs({super.key, required this.gift, required this.onChanged});
  final bool gift;
  final ValueChanged<bool> onChanged;

  static const _earnFlex = 2;
  static const _giftFlex = 1;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Material(
      color: AppColors.white,
      shape: const StadiumBorder(),
      child: SizedBox(
        height: 54,
        child: LayoutBuilder(
          builder: (context, space) {
            final unit = space.maxWidth / (_earnFlex + _giftFlex);
            return Stack(
              children: [
                AnimatedPositioned(
                  key: const Key('rewardsTabIndicator'),
                  duration: AppMotion.duration(context, AppMotion.step),
                  curve: AppMotion.curve,
                  left: gift ? unit * _earnFlex : 0,
                  width: unit * (gift ? _giftFlex : _earnFlex),
                  top: AppSpacing.xs,
                  bottom: AppSpacing.xs,
                  child: const DecoratedBox(
                    decoration: ShapeDecoration(
                      color: AppColors.sky,
                      shape: StadiumBorder(),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Row(
                    children: [
                      _tab(
                        strings.earnTab,
                        _earnFlex,
                        selected: !gift,
                        isGift: false,
                      ),
                      _tab(
                        strings.giftTab,
                        _giftFlex,
                        selected: gift,
                        isGift: true,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _tab(
    String text,
    int flex, {
    required bool selected,
    required bool isGift,
  }) => Expanded(
    flex: flex,
    child: Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.xl),
        onTap: () => onChanged(isGift),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: selected ? AppColors.ink : AppColors.muted,
                fontWeight: selected ? FontWeight.w900 : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
