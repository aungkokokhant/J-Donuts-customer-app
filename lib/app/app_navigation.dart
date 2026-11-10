import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/presentation/unavailable_message.dart';
import '../l10n/app_localizations.dart';
import 'design/app_motion.dart';
import 'design/app_theme.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({
    super.key,
    required this.showRewards,
    required this.onSettings,
  });

  final bool showRewards;
  final VoidCallback onSettings;

  static const _selectedWidthFraction = .30;
  static const _inactiveIconSize = 21.0;
  static const _activeIconSize = 25.0;
  static const _height = 49.0;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            showRewards ? AppColors.catalogSurface : Colors.transparent,
            AppColors.pink,
          ],
          stops: const [.5, .5],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Material(
          color: AppColors.sky,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: AppColors.white),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSpacing.lg),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: AppSpacing.sm,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) =>
                    _layout(context, strings, constraints.maxWidth),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _layout(BuildContext context, AppLocalizations strings, double width) {
    final selectedWidth = width * _selectedWidthFraction;
    final idleWidth = (width - selectedWidth) / 4;
    return TweenAnimationBuilder<double>(
      tween: Tween(end: showRewards ? 1.0 : 0.0),
      duration: AppMotion.duration(context, AppMotion.step),
      curve: AppMotion.curve,
      builder: (context, progress, _) => SizedBox(
        height: _height,
        child: Stack(
          children: [
            _pill(left: idleWidth * progress, width: selectedWidth),
            Positioned.fill(
              child: _buttons(
                context,
                strings,
                progress,
                idleWidth,
                selectedWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill({required double left, required double width}) => Positioned(
    key: const Key('navigationPill'),
    left: left,
    top: AppSpacing.xs,
    bottom: AppSpacing.xs,
    width: width,
    child: const DecoratedBox(
      decoration: ShapeDecoration(
        color: AppColors.pink,
        shape: StadiumBorder(side: BorderSide(color: AppColors.white)),
      ),
    ),
  );

  Widget _buttons(
    BuildContext context,
    AppLocalizations strings,
    double progress,
    double idleWidth,
    double selectedWidth,
  ) => Row(
    children: [
      _navItem(
        context,
        strings.home,
        Icons.home_outlined,
        width: lerpDouble(selectedWidth, idleWidth, progress)!,
        selected: !showRewards,
        reveal: 1 - progress,
        onTap: () => context.go('/home'),
      ),
      _navItem(
        context,
        strings.rewards,
        Icons.emoji_events_outlined,
        width: lerpDouble(idleWidth, selectedWidth, progress)!,
        selected: showRewards,
        reveal: progress,
        onTap: () => context.go('/rewards'),
      ),
      _navItem(
        context,
        strings.menu,
        Icons.donut_small_outlined,
        width: idleWidth,
      ),
      _navItem(
        context,
        strings.wallet,
        Icons.account_balance_wallet_outlined,
        width: idleWidth,
      ),
      _navItem(
        context,
        strings.settings,
        Icons.settings_outlined,
        width: idleWidth,
        onTap: onSettings,
      ),
    ],
  );

  Widget _navItem(
    BuildContext context,
    String label,
    IconData icon, {
    required double width,
    bool selected = false,
    double reveal = 0,
    VoidCallback? onTap,
  }) => SizedBox(
    width: width,
    child: Tooltip(
      message: label,
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        child: InkWell(
          borderRadius: BorderRadius.circular(_height),
          onTap: onTap ?? () => showUnavailableMessage(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: lerpDouble(_inactiveIconSize, _activeIconSize, reveal),
                  color: AppColors.white,
                ),
                if (reveal > 0) ...[
                  SizedBox(width: AppSpacing.xs * reveal),
                  Flexible(child: _label(label, reveal)),
                ],
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _label(String label, double reveal) => ExcludeSemantics(
    child: Opacity(
      opacity: reveal,
      child: ClipRect(
        child: Align(
          alignment: Alignment.centerLeft,
          widthFactor: reveal,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              maxLines: 1,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
