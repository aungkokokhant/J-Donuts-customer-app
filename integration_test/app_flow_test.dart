import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jdonuts_customer_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('registers, logs out and logs back in with a local account', (
    tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();

    if (find.byTooltip('Settings').evaluate().isNotEmpty) {
      await _logOut(tester);
    }
    final suffix = (DateTime.now().microsecondsSinceEpoch % 100000000)
        .toString()
        .padLeft(8, '0');
    final phone = '9$suffix';

    await _tap(tester, find.text('LET’S GET STARTED'));
    await _verifyPhone(tester, phone);
    await tester.enterText(
      find.widgetWithText(TextField, 'First name'),
      'Demo',
    );
    await tester.pumpAndSettle();
    await _tap(tester, find.text('CONTINUE'));
    await _tap(tester, find.byKey(const Key('birthMonth')));
    await _tap(tester, find.text('January').last);
    await tester.enterText(find.widgetWithText(TextField, 'Day'), '15');
    await tester.enterText(find.widgetWithText(TextField, 'Year'), '2000');
    await tester.pumpAndSettle();
    await _tap(tester, find.text('CONTINUE'));
    await _tap(tester, find.text('LET’S EXPLORE'));

    expect(find.text('Home'), findsOneWidget);
    await _logOut(tester);
    await _tap(tester, find.text('Log in'));
    await _verifyPhone(tester, phone);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Demo'), findsOneWidget);
    await _logOut(tester);
  });
}

Future<void> _verifyPhone(WidgetTester tester, String phone) async {
  await tester.enterText(find.byKey(const Key('phoneInput')), phone);
  await tester.pumpAndSettle();
  await _tap(tester, find.text('CONTINUE'));
  await tester.enterText(find.byKey(const Key('otpInput')), '123456');
  await tester.pumpAndSettle();
}

Future<void> _logOut(WidgetTester tester) async {
  await _tap(tester, find.byTooltip('Settings'));
  await _tap(tester, find.text('Log out'));
}

Future<void> _tap(WidgetTester tester, Finder target) async {
  await tester.ensureVisible(target);
  await tester.tap(target);
  await tester.pumpAndSettle();
}
