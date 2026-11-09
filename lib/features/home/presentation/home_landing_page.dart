import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/design/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/session_controller.dart';

class HomeLandingPage extends StatelessWidget {
  const HomeLandingPage({super.key, required this.session});

  final SessionController session;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.home),
        actions: [
          IconButton(
            tooltip: strings.settings,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _settings(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Text(
          session.user?.firstName ?? '',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
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
    final loggedOut = await session.logout();
    if (!context.mounted) return;
    if (loggedOut) {
      context.go('/');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(strings.authError)));
    }
  }
}
