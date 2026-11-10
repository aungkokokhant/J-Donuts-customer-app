import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../l10n/app_localizations.dart';

enum AppLanguage {
  system(null),
  english(Locale('en')),
  burmese(Locale('my'));

  const AppLanguage(this.locale);
  final Locale? locale;

  String label(AppLocalizations strings) => switch (this) {
    system => strings.systemLanguage,
    english => 'English',
    burmese => 'မြန်မာ',
  };
}

final appLanguageProvider =
    AsyncNotifierProvider<LanguagePreference, AppLanguage>(
      LanguagePreference.new,
    );

class LanguagePreference extends AsyncNotifier<AppLanguage> {
  static const _key = 'app_language';
  static const _storage = FlutterSecureStorage();
  bool _saving = false;

  @override
  Future<AppLanguage> build() async {
    try {
      final code = await _storage.read(key: _key);
      return AppLanguage.values.firstWhere(
        (language) => language.locale?.languageCode == code,
        orElse: () => AppLanguage.system,
      );
    } on PlatformException {
      return AppLanguage.system;
    } on MissingPluginException {
      return AppLanguage.system;
    }
  }

  Future<bool> select(AppLanguage language) async {
    if (state.isLoading || _saving) return false;
    if (state.value == language) return true;

    _saving = true;
    final saved = await AsyncValue.guard(() async {
      final code = language.locale?.languageCode;
      if (code == null) {
        await _storage.delete(key: _key);
      } else {
        await _storage.write(key: _key, value: code);
      }
      return language;
    });
    _saving = false;
    if (ref.mounted && !saved.hasError) state = saved;
    return !saved.hasError;
  }
}
