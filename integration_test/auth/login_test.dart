import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';

Future<void> loginWithValidCredentials(WidgetTester tester) async {
  print('\x1B[32mStarting loginWithValidCredentials\x1B[0m');
  await tester.enterText(
    find.byKey(const Key('email_field')),
    'karim@midade.com',
  );
  await tester.enterText(find.byKey(const Key('password_field')), '123123');
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await verifyHomeScreen(tester);
  print('\x1B[32mloginWithValidCredentials completed\x1B[0m');

}

Future<void> verifyHomeScreen(WidgetTester tester) async {
  print('\x1B[32mStarting verifyHomeScreen\x1B[0m');
  expect(find.byKey(const Key('home_screen')), findsOneWidget);
  print('\x1B[32mverifyHomeScreen completed\x1B[0m');
}

Future<void> testInvalidEmail(WidgetTester tester) async {
  print('\x1B[32mStarting testInvalidEmail\x1B[0m');
  await tester.pumpAndSettle();
  await tester.enterText(
    find.byKey(const Key('email_field')),
    'wrongemail.com',
  );
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key('password_field')), '123123');
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle();
  final translator =
      AppLocalizations.of(
        tester.element(find.byKey(const Key('login_screen'))),
      )!;
  expect(find.text(translator.translate('email_not_valid')!), findsOneWidget);
  await tester.pumpAndSettle();
  print('\x1B[32mtestInvalidEmail completed\x1B[0m');
}

Future<void> testEmptyEmail(WidgetTester tester) async {
  print('\x1B[32mStarting testEmptyEmail\x1B[0m');
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key('email_field')), '');
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key('password_field')), '123123');
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle();
  final translator =
      AppLocalizations.of(
        tester.element(find.byKey(const Key('login_screen'))),
      )!;
  expect(find.text(translator.translate('email_validation')!), findsOneWidget);
  print('\x1B[32mtestEmptyEmail completed\x1B[0m');
}

Future<void> testEmptyPassword(WidgetTester tester) async {
  print('\x1B[32mStarting testEmptyPassword\x1B[0m');
  await tester.enterText(
    find.byKey(const Key('email_field')),
    'test@example.com',
  );
  await tester.enterText(find.byKey(const Key('password_field')), '');
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle();
  final translator =
      AppLocalizations.of(
        tester.element(find.byKey(const Key('login_screen'))),
      )!;
  expect(
    find.text(translator.translate('password_validation')!),
    findsOneWidget,
  );
  print('\x1B[32mtestEmptyPassword completed\x1B[0m');
}

Future<void> verifyLoginScreenTranslations(WidgetTester tester) async {
  // final translator =
  //     AppLocalizations.of(
  //       tester.element(find.byKey(const Key('login_screen')),),
  //     )!;
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('login_title')), findsOneWidget);
  expect(find.byKey(const Key('login_button')), findsOneWidget);
  // expect(
  //   find.text(translator.translate('email')!),
  //   findsNWidgets(2),
  // ); // label + hint
  // expect(find.text(translator.translate('password')!), findsNWidgets(2));
  // expect(find.text(translator.translate('remember_me')!), findsOneWidget);
  // expect(find.text(translator.translate('forgot_password')!), findsOneWidget);
  // expect(find.text(translator.translate('sign_in')!), findsOneWidget);
  // expect(find.text(translator.translate('or_login_with')!), findsOneWidget);
  // expect(
  //   find.text(translator.translate("don't_have_account?")!),
  //   findsOneWidget,
  // );
  // expect(find.text(translator.translate('register_now')!), findsOneWidget);
  // expect(
  //   find.text(translator.translate('contiue_as_visitor')!),
  //   findsOneWidget,
  // );
}
