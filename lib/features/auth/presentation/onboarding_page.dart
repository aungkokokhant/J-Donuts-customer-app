import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../app/design/app_motion.dart';
import '../../../app/design/app_theme.dart';
import '../../../core/presentation/primary_action_button.dart';
import '../../../core/presentation/unavailable_message.dart';
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
  static const _accountFontSize = 16.0;
  static const _socialIconSize = 30.0;

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
        child: PrimaryActionButton(
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
            Text(
              strings.haveAccount,
              style: const TextStyle(fontSize: _accountFontSize),
            ),
            TextButton(
              onPressed: () => context.push('/auth?mode=login'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                textStyle: const TextStyle(
                  fontFamily: AppTypography.bodyFamily,
                  fontFamilyFallback: AppTypography.fontFallback,
                  fontSize: _accountFontSize,
                  fontWeight: AppTypography.strongWeight,
                ),
              ),
              child: Text(strings.logIn),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      EnterMotion(
        index: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              tooltip: strings.google,
              icon: SvgPicture.asset(
                'assets/images/google_sign_in.svg',
                width: AppSpacing.lg,
                height: AppSpacing.lg,
                excludeFromSemantics: true,
              ),
              onPressed: () => showUnavailableMessage(context),
            ),
            const SizedBox(width: AppSpacing.lg),
            IconButton(
              tooltip: strings.apple,
              iconSize: _socialIconSize,
              icon: const Icon(Icons.apple, color: AppColors.ink),
              onPressed: () => showUnavailableMessage(context),
            ),
            const SizedBox(width: AppSpacing.lg),
            IconButton(
              tooltip: strings.facebook,
              iconSize: _socialIconSize,
              icon: const Icon(Icons.facebook, color: AppColors.socialBlue),
              onPressed: () => showUnavailableMessage(context),
            ),
          ],
        ),
      ),
    ],
  );
}
