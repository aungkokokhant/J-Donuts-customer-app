import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app_router.dart';
import 'app/design/app_theme.dart';
import 'l10n/app_localizations.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/Nunito-OFL.txt');
    yield LicenseEntryWithLineBreaks(['Nunito'], license);
  });
  runApp(const ProviderScope(child: JDonutsApp()));
}

class JDonutsApp extends ConsumerWidget {
  const JDonutsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
    debugShowCheckedModeBanner: false,
    theme: appTheme(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    routerConfig: ref.watch(appRouterProvider),
  );
}
