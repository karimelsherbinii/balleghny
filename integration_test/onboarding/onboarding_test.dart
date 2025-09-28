import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

Future<void> completeOnboarding(WidgetTester tester) async {
  //log and  //make this string colored green
  print('\x1B[32mStarting Onboarding\x1B[0m');
  final nextButton = find.byKey(const Key('onboarding_next_button'));

  await tester.pumpAndSettle(const Duration(seconds: 5));

  expect(find.byKey(const Key('onboarding_step1_title')), findsOneWidget);
  await tester.tap(nextButton);
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('onboarding_step2_title')), findsOneWidget);
  await tester.tap(nextButton);
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('onboarding_step3_title')), findsOneWidget);
  await tester.tap(nextButton);
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('login_screen')), findsOneWidget);
  print('\x1B[32mOnboarding completed\x1B[0m');
}
