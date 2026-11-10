import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts_customer_app/app/app_router.dart';
import 'package:jdonuts_customer_app/app/design/app_theme.dart';
import 'package:jdonuts_customer_app/app/network_status.dart';
import 'package:jdonuts_customer_app/app/repository_providers.dart';
import 'package:jdonuts_customer_app/core/domain/member_profile.dart';
import 'package:jdonuts_customer_app/core/domain/result.dart';
import 'package:jdonuts_customer_app/core/presentation/catalog_state.dart';
import 'package:jdonuts_customer_app/features/auth/domain/auth_repository.dart';
import 'package:jdonuts_customer_app/features/auth/domain/auth_validation.dart';
import 'package:jdonuts_customer_app/features/home/domain/home_repository.dart';
import 'package:jdonuts_customer_app/features/home/presentation/home_landing_page.dart';
import 'package:jdonuts_customer_app/features/product/domain/product_repository.dart';
import 'package:jdonuts_customer_app/features/rewards/domain/rewards_repository.dart';
import 'package:jdonuts_customer_app/features/rewards/presentation/rewards_page.dart';
import 'package:jdonuts_customer_app/l10n/app_localizations.dart';
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

class _FakeHome implements HomeRepository {
  @override
  Future<Result<MemberProfile?>> loadMember(String id) async => Success((
    id: id,
    name: 'Hania',
    imageKey: 'member_avatar',
    tier: 'Silver',
    nextTier: 'Gold',
    pointsToNextTier: 500,
    totalPoints: 680000,
    tierStartPoints: 678500,
    notificationCount: 2,
    availableRewards: 3,
  ));

  @override
  Future<Result<List<HomeBanner>>> loadBanners() async => const Success([]);

  @override
  Future<Result<List<ProductSection>>> loadSections() async =>
      const Success([]);

  @override
  Future<Result<List<CatalogProduct>>> loadSectionProducts(
    String sectionId,
  ) async => const Success([]);

  @override
  Future<Result<List<NearbyShop>>> loadShops() async => const Success([]);
}

class _IsolatedSectionsHome extends _FakeHome {
  final firstPopularLoad = Completer<Result<List<CatalogProduct>>>();
  final loads = <String, int>{};
  bool popularIsEmpty = false;

  @override
  Future<Result<List<ProductSection>>> loadSections() async => const Success([
    (id: 'seasonal', title: 'Seasonal specials'),
    (id: 'popular', title: 'Popular'),
    (id: 'order_again', title: 'Order again'),
  ]);

  @override
  Future<Result<List<CatalogProduct>>> loadSectionProducts(
    String sectionId,
  ) async {
    final count = loads.update(
      sectionId,
      (value) => value + 1,
      ifAbsent: () => 1,
    );
    if (sectionId == 'popular' && count == 1) return firstPopularLoad.future;
    if (sectionId == 'popular' && popularIsEmpty) return const Success([]);
    return Success([
      (
        id: sectionId,
        code: 'JD022123',
        name: 'Donut for $sectionId',
        priceMmk: 3200,
        isNew: false,
        discountPercent: null,
        imageKey: 'coconut_donut',
        description: '',
      ),
    ]);
  }
}

class _FakeRewards implements RewardsRepository {
  @override
  Future<Result<MemberProfile?>> loadMember(String id) =>
      _FakeHome().loadMember(id);

  @override
  Future<Result<List<RewardChallenge>>> loadChallenges(String memberId) async =>
      const Success([
        (
          id: 'challenge',
          title: 'Eat 4 Coco donuts',
          kind: ChallengeKind.donut,
          completed: 1,
          target: 4,
          points: 100,
          imageKey: 'challenge_donut',
        ),
      ]);
}

const _phoneInput = Key('phoneInput');
const _otpInput = Key('otpInput');

Future<void> _start(WidgetTester tester, _FakeAuth auth) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(auth),
        homeRepositoryProvider.overrideWithValue(_FakeHome()),
        networkOnlineProvider.overrideWith((ref) => Stream.value(false)),
      ],
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
    'each Home rail loads, shows failures and retries independently',
    (tester) async {
      tester.view.physicalSize = const Size(430, 1450);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final home = _IsolatedSectionsHome();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homeRepositoryProvider.overrideWithValue(home),
            networkOnlineProvider.overrideWith((ref) => Stream.value(false)),
          ],
          child: MaterialApp(
            theme: appTheme(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const HomeLandingPage(memberName: null),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      final popular = find.byKey(const PageStorageKey('popular'));
      Finder inPopular(Finder item) =>
          find.descendant(of: popular, matching: item);
      expect(inPopular(find.byType(CatalogSkeleton)), findsOneWidget);
      expect(find.byKey(const ValueKey('rail-seasonal')), findsOneWidget);
      expect(find.byKey(const ValueKey('rail-order_again')), findsOneWidget);

      home.firstPopularLoad.complete(
        Failure(
          LocalDataFailure(StateError('Popular unavailable'), StackTrace.empty),
        ),
      );
      await tester.pumpAndSettle();
      expect(inPopular(find.text('Retry')), findsOneWidget);
      expect(find.byKey(const ValueKey('rail-seasonal')), findsOneWidget);
      expect(find.byKey(const ValueKey('rail-order_again')), findsOneWidget);

      await tester.tap(inPopular(find.text('Retry')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('rail-popular')), findsOneWidget);
      expect(find.text('Retry'), findsNothing);
      expect(home.loads, {'seasonal': 1, 'popular': 2, 'order_again': 1});

      home.popularIsEmpty = true;
      final refresh = tester.state<RefreshIndicatorState>(
        find.byType(RefreshIndicator),
      );
      unawaited(refresh.show());
      await tester.pumpAndSettle();
      final strings = AppLocalizations.of(tester.element(popular));
      expect(inPopular(find.text(strings.emptySection)), findsOneWidget);
      expect(home.loads, {'seasonal': 2, 'popular': 3, 'order_again': 2});
    },
  );

  testWidgets(
    'auth stays scrollable on a narrow screen with the keyboard open',
    (tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 1.3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetViewInsets);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await _start(tester, _FakeAuth());
      final start = find.text('LET’S GET STARTED');
      await tester.ensureVisible(start);
      await tester.tap(start);
      await tester.pumpAndSettle();

      tester.view.viewInsets = const FakeViewPadding(bottom: 220);
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(_phoneInput), '09254135592');
      await tester.pumpAndSettle();
      final next = find.text('CONTINUE');
      await tester.ensureVisible(next);
      await tester.tap(next);
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(_otpInput));
      await tester.enterText(find.byKey(_otpInput), fakeOtp);
      await tester.pumpAndSettle();
      expect(find.text('What’s your name?'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Rewards fits a narrow viewport with larger text and reduced motion',
    (tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homeRepositoryProvider.overrideWithValue(_FakeHome()),
            rewardsRepositoryProvider.overrideWithValue(_FakeRewards()),
            networkOnlineProvider.overrideWith((ref) => Stream.value(false)),
          ],
          child: MaterialApp(
            theme: appTheme(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.3),
                disableAnimations: true,
              ),
              child: child!,
            ),
            home: const RewardsPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('680,000'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('Eat more earn more'), 90);
      final indicator = tester.widget<AnimatedPositioned>(
        find.byKey(const Key('rewardsTabIndicator')),
      );
      expect(indicator.duration, Duration.zero);
      await tester.scrollUntilVisible(find.text('Eat 4 Coco donuts'), 120);
      expect(tester.takeException(), isNull);
    },
  );

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
    final otp = find.byKey(_otpInput);
    final input = tester.widget<TextField>(otp);
    expect(input.keyboardType, TextInputType.number);
    expect(input.autofillHints, contains(AutofillHints.oneTimeCode));
    await tester.enterText(otp, '12');
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
    tester.testTextInput.updateEditingValue(
      const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      ),
    );
    await tester.pump();
    expect(find.text('2'), findsNothing);
    expect(
      find.byWidgetPredicate((widget) => widget is Text && widget.data == '1'),
      findsOneWidget,
    );
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
