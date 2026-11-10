import 'dart:async';
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/presentation/unavailable_message.dart';
import '../features/auth/presentation/session_controller.dart';
import '../l10n/app_localizations.dart';
import 'design/app_motion.dart';
import 'design/app_theme.dart';
import 'network_status.dart';

enum _SettingsAction { cart, logout }

class AppShell extends ConsumerStatefulWidget {
  const AppShell({
    super.key,
    required this.location,
    required this.session,
    required this.child,
  });

  final String location;
  final SessionController session;
  final Widget child;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onResume: () => ref.invalidate(networkOnlineProvider),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHome = widget.location == '/home';
    final isRewards = widget.location == '/rewards';
    return Scaffold(
      backgroundColor: AppColors.catalogSurface,
      extendBody: isHome,
      body: widget.child,
      bottomNavigationBar: isHome || isRewards
          ? _AppNavigation(
              showRewards: isRewards,
              onSettings: () => unawaited(_settings(context)),
            )
          : null,
    );
  }

  Future<void> _settings(BuildContext context) async {
    final strings = AppLocalizations.of(context);
    final action = await showModalBottomSheet<_SettingsAction>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: Text(strings.cartTitle),
              onTap: () => Navigator.of(context).pop(_SettingsAction.cart),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(strings.logOut),
              onTap: () => Navigator.of(context).pop(_SettingsAction.logout),
            ),
          ],
        ),
      ),
    );
    if (!context.mounted || action == null) return;
    if (action == _SettingsAction.cart) {
      unawaited(context.push('/cart'));
      return;
    }
    final loggedOut = await widget.session.logout();
    if (!context.mounted) return;
    if (loggedOut) {
      context.go('/');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(strings.authError)));
    }
  }
}

class _AppNavigation extends StatelessWidget {
  const _AppNavigation({required this.showRewards, required this.onSettings});

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
