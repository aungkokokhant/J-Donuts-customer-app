import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/auth_chrome.dart';
import '../features/auth/presentation/session_controller.dart';
import '../l10n/app_localizations.dart';
import 'design/app_motion.dart';
import 'design/app_theme.dart';
import 'network_status.dart';

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
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => SafeArea(
        child: ListTile(
          leading: const Icon(Icons.logout),
          title: Text(strings.logOut),
          onTap: () => Navigator.of(context).pop(true),
        ),
      ),
    );
    if (confirmed != true || !context.mounted) return;
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

  static const _tabFlex = 2;
  static const _totalFlex = _tabFlex * 2 + 3;
  static const _height = 49.0;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.catalogSurface, AppColors.pink],
          stops: [.62, .62],
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
    final tabWidth = width * _tabFlex / _totalFlex;
    return SizedBox(
      height: _height,
      child: Stack(
        children: [
          AnimatedPositioned(
            key: const Key('navigationPill'),
            duration: AppMotion.duration(context, AppMotion.step),
            curve: AppMotion.curve,
            left: showRewards ? tabWidth : 0,
            top: AppSpacing.xs,
            bottom: AppSpacing.xs,
            width: tabWidth,
            child: const DecoratedBox(
              decoration: ShapeDecoration(
                color: AppColors.pink,
                shape: StadiumBorder(side: BorderSide(color: AppColors.white)),
              ),
            ),
          ),
          Positioned.fill(child: _buttons(context, strings)),
        ],
      ),
    );
  }

  Widget _buttons(BuildContext context, AppLocalizations strings) => Row(
    children: [
      _navItem(
        context,
        strings.home,
        Icons.home_outlined,
        selected: !showRewards,
        flex: _tabFlex,
        onTap: () => context.go('/home'),
      ),
      _navItem(
        context,
        strings.rewards,
        Icons.emoji_events_outlined,
        selected: showRewards,
        flex: _tabFlex,
        onTap: () => context.go('/rewards'),
      ),
      _navItem(context, strings.menu, Icons.donut_small_outlined),
      _navItem(context, strings.wallet, Icons.account_balance_wallet_outlined),
      _navItem(
        context,
        strings.settings,
        Icons.settings_outlined,
        onTap: onSettings,
      ),
    ],
  );

  Widget _navItem(
    BuildContext context,
    String label,
    IconData icon, {
    bool selected = false,
    int flex = 1,
    VoidCallback? onTap,
  }) => Expanded(
    flex: flex,
    child: Tooltip(
      message: label,
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        child: InkWell(
          borderRadius: BorderRadius.circular(_height),
          onTap: onTap ?? () => showAuthPlaceholder(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 21, color: AppColors.white),
                if (selected) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
