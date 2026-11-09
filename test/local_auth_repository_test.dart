import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts_customer_app/core/data/app_database.dart'
    hide RegisteredUser;
import 'package:jdonuts_customer_app/core/domain/result.dart';
import 'package:jdonuts_customer_app/features/auth/data/local_auth_repository.dart';
import 'package:jdonuts_customer_app/features/auth/domain/auth_repository.dart';
import 'package:jdonuts_customer_app/features/auth/domain/auth_validation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalAuthRepository auth;
  final user = (
    phone: '+959254135592',
    firstName: 'Hania',
    lastName: '',
    birthDate: DateTime(2000, 1, 15),
  );

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    final database = AppDatabase(
      NativeDatabase.memory(),
      loadSeed: () => rootBundle.loadString('assets/data/catalog.json'),
    );
    addTearDown(database.close);
    auth = LocalAuthRepository(database, const FlutterSecureStorage());
  });

  test('verifies only the demo OTP', () async {
    expect(
      await auth.verifyCode(user.phone, '000000'),
      isA<Success<bool>>().having((result) => result.value, 'verified', false),
    );
    expect(
      await auth.verifyCode(user.phone, fakeOtp),
      isA<Success<bool>>().having((result) => result.value, 'verified', true),
    );
  });

  test(
    'registers once, restores the session and clears it on logout',
    () async {
      expect(
        await auth.register(user),
        isA<Success<bool>>().having((result) => result.value, 'created', true),
      );
      expect(
        await auth.register((
          phone: user.phone,
          firstName: 'Other',
          lastName: '',
          birthDate: user.birthDate,
        )),
        isA<Success<bool>>().having((result) => result.value, 'created', false),
      );
      expect(await auth.saveSession(user), isA<Success<void>>());
      expect(await auth.restoreSession(), _hasUser(user));
      expect(await auth.logout(), isA<Success<void>>());
      expect(await auth.restoreSession(), _hasUser(null));
      expect(await auth.findUser(user.phone), _hasUser(user));
    },
  );
}

Matcher _hasUser(RegisteredUser? value) => isA<Success<RegisteredUser?>>()
    .having((result) => result.value, 'user', value);
