import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import 'auth_chrome.dart';
import 'donut_art.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static const _background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.landingWhite,
      AppColors.landingWhite,
      AppColors.landingPink,
      AppColors.landingPink,
    ],
    stops: [0, .34, .52, 1],
  );

  @override
  Widget build(BuildContext context) => AuthBackground(
    gradient: _background,
    safeTop: false,
    child: LayoutBuilder(
      builder: (context, limits) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: limits.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _mainContent(context, limits),
              const Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
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
  );

  Widget _mainContent(BuildContext context, BoxConstraints limits) => Column(
    children: [
      DonutArt(height: (limits.maxHeight * .54).clamp(210, 490)),
      Padding(
        padding: const EdgeInsets.fromLTRB(
          AuthLayout.pageInset,
          AppSpacing.lg,
          AuthLayout.pageInset,
          AppSpacing.sm,
        ),
        child: _OnboardingActions(
          strings: AppLocalizations.of(context),
          headingSize: (limits.maxWidth * .088).clamp(28, 38),
        ),
      ),
    ],
  );
}

class _OnboardingActions extends StatelessWidget {
  const _OnboardingActions({required this.strings, required this.headingSize});
  final AppLocalizations strings;
  final double headingSize;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      EnterMotion(
        index: 1,
        child: Text(
          strings.onboardingTitle,
          textAlign: TextAlign.center,
          style: AuthLayout.heading(context)
              ?.copyWith(fontSize: headingSize, height: 1.10),
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
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                textStyle: AppTypography.button,
              ),
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
            const SizedBox(width: AppSpacing.lg),
            IconButton(
              tooltip: strings.apple,
              icon: const Icon(Icons.apple, color: AppColors.ink),
              onPressed: () => showAuthPlaceholder(context),
            ),
            const SizedBox(width: AppSpacing.lg),
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
