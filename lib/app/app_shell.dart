import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/session_controller.dart';
import '../l10n/app_localizations.dart';
import 'app_language.dart';
import 'app_navigation.dart';
import 'design/app_theme.dart';
import 'network_status.dart';

enum _SettingsAction { cart, language, logout }

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
          ? AppNavigation(
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
              leading: const Icon(Icons.language),
              title: Text(strings.languageTitle),
              onTap: () => Navigator.of(context).pop(_SettingsAction.language),
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
    if (action == _SettingsAction.language) {
      await _selectLanguage(context);
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

  Future<void> _selectLanguage(BuildContext context) async {
    final strings = AppLocalizations.of(context);
    final current = await ref.read(appLanguageProvider.future);
    if (!context.mounted) return;
    final selected = await showDialog<AppLanguage>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(strings.languageTitle),
        children: [
          for (final language in AppLanguage.values)
            ListTile(
              title: Text(language.label(strings)),
              selected: language == current,
              trailing: language == current ? const Icon(Icons.check) : null,
              onTap: () => Navigator.of(context).pop(language),
            ),
        ],
      ),
    );
    if (!context.mounted || selected == null) return;
    final saved = await ref.read(appLanguageProvider.notifier).select(selected);
    if (!context.mounted || saved) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(strings.languageUpdateFailed)));
  }
}
