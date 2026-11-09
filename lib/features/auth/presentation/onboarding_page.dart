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
                  DonutArt(height: (limits.maxHeight * .51).clamp(215, 440)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AuthLayout.pageInset,
                      AppSpacing.sm,
                      AuthLayout.pageInset,
                      AppSpacing.sm,
                    ),
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
          style: AuthLayout.heading(context),
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
              icon: const _GoogleMark(),
              onPressed: () => showAuthPlaceholder(context),
            ),
            IconButton(
              tooltip: strings.apple,
              icon: const Icon(Icons.apple, color: AppColors.ink),
              onPressed: () => showAuthPlaceholder(context),
            ),
            IconButton(
              tooltip: strings.facebook,
              icon: const Icon(Icons.facebook, color: AppColors.socialBlue),
              onPressed: () => showAuthPlaceholder(context),
            ),
          ],
        ),
      ),
    ],
  );
}

class _GoogleMark extends StatelessWidget {
  const _GoogleMark();

  @override
  Widget build(BuildContext context) => ShaderMask(
    blendMode: BlendMode.srcIn,
    shaderCallback: (bounds) => const SweepGradient(
      colors: [
        AppColors.googleBlue,
        AppColors.googleGreen,
        AppColors.googleYellow,
        AppColors.googleRed,
        AppColors.googleBlue,
      ],
      stops: [0, .25, .42, .65, 1],
    ).createShader(bounds),
    child: const Text(
      'G',
      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 21),
    ),
  );
}
