import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts_customer_app/app/app_router.dart';
import 'package:jdonuts_customer_app/core/domain/result.dart';
import 'package:jdonuts_customer_app/features/auth/domain/auth_repository.dart';
import 'package:jdonuts_customer_app/features/auth/domain/auth_validation.dart';
import 'package:jdonuts_customer_app/main.dart';

class _FakeAuth implements AuthRepository {
  final users = <String, RegisteredUser>{};
  RegisteredUser? active;
  int requests = 0;

  @override
  Future<Result<void>> requestCode(String phone) async {
    requests++;
    await Future<void>.delayed(const Duration(seconds: 1));
    return const Success(null);
  }

  @override
  Future<Result<bool>> verifyCode(String phone, String code) async =>
      Success(code == fakeOtp);

  @override
  Future<Result<RegisteredUser?>> findUser(String phone) async =>
      Success(users[phone]);

  @override
  Future<Result<void>> confirmName(String firstName, String lastName) async =>
      const Success(null);

  @override
  Future<Result<bool>> register(RegisteredUser user) async {
    users[user.phone] = user;
    return const Success(true);
  }

  @override
  Future<Result<RegisteredUser?>> restoreSession() async => Success(active);

  @override
  Future<Result<void>> saveSession(RegisteredUser user) async {
    active = user;
    return const Success(null);
  }

  @override
  Future<Result<void>> logout() async {
    active = null;
    return const Success(null);
  }
}

const _phoneInput = Key('phoneInput');
const _otpInput = Key('otpInput');

Future<void> _start(WidgetTester tester, _FakeAuth auth) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [authRepositoryProvider.overrideWithValue(auth)],
      child: const JDonutsApp(),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _sendPhone(WidgetTester tester) async {
  await tester.enterText(find.byKey(_phoneInput), '09 254-135592');
  await tester.pump();
  await tester.tap(find.text('CONTINUE'));
  await tester.tap(find.text('CONTINUE'));
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'a restored session opens Home and a cleared session opens Onboarding',
    (tester) async {
      final auth = _FakeAuth()
        ..active = (
          phone: '+959254135592',
          firstName: 'Demo',
          lastName: '',
          birthDate: DateTime(2000, 1, 15),
        );
      await _start(tester, auth);
      expect(find.text('Home'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
      auth.active = null;
      await _start(tester, auth);
      expect(find.text('LET’S GET STARTED'), findsOneWidget);
    },
  );

  testWidgets('rejects an invalid phone and preserves a valid phone on back', (
    tester,
  ) async {
    final auth = _FakeAuth();
    await _start(tester, auth);
    await tester.tap(find.text('LET’S GET STARTED'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(_phoneInput), '123');
    await tester.pump();
    tester.widget<TextField>(find.byKey(_phoneInput)).focusNode!.unfocus();
    await tester.pumpAndSettle();
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
    expect(find.text('Enter a valid Myanmar phone number.'), findsOneWidget);
    expect(auth.requests, 0);

    await _sendPhone(tester);
    expect(auth.requests, 1);
    expect(
      find.text('We’ve sent a 6-digit OTP to +959254135592'),
      findsOneWidget,
    );
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    final field = tester.widget<TextField>(find.byKey(_phoneInput));
    expect(field.controller?.text, '09 254-135592');
  });

  testWidgets('three wrong OTPs lock input until the resend timer ends', (
    tester,
  ) async {
    final auth = _FakeAuth();
    await _start(tester, auth);
    await tester.tap(find.text('LET’S GET STARTED'));
    await tester.pumpAndSettle();
    await _sendPhone(tester);

    for (var attempt = 0; attempt < 3; attempt++) {
      await tester.enterText(find.byKey(_otpInput), '111111');
      await tester.pumpAndSettle();
    }

    final input = tester.widget<TextField>(find.byKey(_otpInput));
    expect(input.enabled, isFalse);
    expect(input.controller?.text, isEmpty);
    expect(
      find.text('Too many attempts. Wait until you can resend the code.'),
      findsOneWidget,
    );
    expect(find.text('Resend'), findsNothing);

    await tester.pump(const Duration(minutes: 5));
    await tester.tap(find.text('Resend'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(find.byKey(_otpInput)).enabled, isTrue);
    expect(auth.requests, 2);
  });

  testWidgets('unknown login number can switch to registration', (
    tester,
  ) async {
    final auth = _FakeAuth();
    await _start(tester, auth);
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
    await _sendPhone(tester);
    await tester.enterText(find.byKey(_otpInput), fakeOtp);
    await tester.pumpAndSettle();

    expect(find.text('This number hasn’t registered yet.'), findsOneWidget);
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    expect(find.byKey(_phoneInput), findsOneWidget);
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(_otpInput), fakeOtp);
    await tester.pumpAndSettle();
    expect(find.text('What’s your name?'), findsOneWidget);
  });

  testWidgets('registers with a Myanmar name, reaches Home and logs out', (
    tester,
  ) async {
    final auth = _FakeAuth();
    await _start(tester, auth);
    await tester.tap(find.text('LET’S GET STARTED'));
    await tester.pumpAndSettle();
    await _sendPhone(tester);
    await tester.enterText(find.byKey(_otpInput), fakeOtp);
    await tester.pumpAndSettle();

    final name = find.widgetWithText(TextField, 'First name');
    await tester.enterText(name, 'Aung 2');
    await tester.pumpAndSettle();
    expect(find.text('Use 1–50 letters and spaces.'), findsOneWidget);
    await tester.enterText(name, 'အောင် ခန့်');
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('birthMonth')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('January').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Day'), '15');
    await tester.enterText(find.widgetWithText(TextField, 'Year'), '2000');
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('LET’S EXPLORE'));
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
    expect(auth.active?.firstName, 'အောင် ခန့်');
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();
    expect(auth.active, isNull);
    expect(find.text('LET’S GET STARTED'), findsOneWidget);
  });
}
