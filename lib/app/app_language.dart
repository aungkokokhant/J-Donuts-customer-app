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

  String get storageCode => locale?.languageCode ?? 'system';

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
        (language) => language.storageCode == code,
        orElse: () => AppLanguage.english,
      );
    } on PlatformException {
      return AppLanguage.english;
    } on MissingPluginException {
      return AppLanguage.english;
    }
  }

  Future<bool> select(AppLanguage language) async {
    if (state.isLoading || _saving) return false;
    if (state.value == language) return true;

    _saving = true;
    final saved = await AsyncValue.guard(() async {
      await _storage.write(key: _key, value: language.storageCode);
      return language;
    });
    _saving = false;
    if (ref.mounted && !saved.hasError) state = saved;
    return !saved.hasError;
  }
}
