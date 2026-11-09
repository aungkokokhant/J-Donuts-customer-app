import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import 'auth_chrome.dart';
import 'donut_art.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return AuthBackground(
      child: LayoutBuilder(
        builder: (context, limits) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: limits.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const DonutArt(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: _OnboardingActions(strings: strings),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.sm,
                      AppSpacing.lg,
                      AppSpacing.lg,
                    ),
                    child: AuthLegal(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingActions extends StatelessWidget {
  const _OnboardingActions({required this.strings});
  final AppLocalizations strings;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      EnterMotion(
        index: 1,
        child: Text(
          strings.onboardingTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      const SizedBox(height: AppSpacing.lg),
      EnterMotion(
        index: 2,
        child: AuthButton(
          label: strings.getStarted,
          onPressed: () => context.push('/auth?mode=register'),
        ),
      ),
      EnterMotion(
        index: 3,
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(strings.haveAccount),
            TextButton(
              onPressed: () => context.push('/auth?mode=login'),
              child: Text(strings.logIn),
            ),
          ],
        ),
      ),
      EnterMotion(
        index: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              tooltip: strings.google,
              icon: const Text(
                'G',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 21),
              ),
              onPressed: () => showAuthPlaceholder(context),
            ),
            IconButton(
              tooltip: strings.apple,
              icon: const Icon(Icons.apple),
              onPressed: () => showAuthPlaceholder(context),
            ),
            IconButton(
              tooltip: strings.facebook,
              icon: const Icon(Icons.facebook),
              onPressed: () => showAuthPlaceholder(context),
            ),
          ],
        ),
      ),
    ],
  );
}
