import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app_language.dart';
import 'app/app_router.dart';
import 'app/design/app_theme.dart';
import 'l10n/app_localizations.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    for (final family in [
      AppTypography.adlamFamily,
      AppTypography.abelFamily,
      AppTypography.myanmarFamily,
    ]) {
      final license = await rootBundle.loadString(
        'assets/fonts/$family-OFL.txt',
      );
      yield LicenseEntryWithLineBreaks([family], license);
    }
  });
  runApp(const ProviderScope(child: JDonutsApp()));
}

class JDonutsApp extends ConsumerWidget {
  const JDonutsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language =
        ref.watch(appLanguageProvider).value ?? AppLanguage.english;
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      locale: language.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
