import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ballaghny/main.dart' as app;

import 'auth/login_test.dart';
import 'onboarding/onboarding_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('\x1B[34mFull App Flow Test\x1B[0m', () {
    testWidgets(
      '\x1B[34mUser completes onboarding and logs in with valid credentials\x1B[0m',
      (tester) async {
        app.main(isTest: true);
        await tester.pumpAndSettle();
        await completeOnboarding(tester);
        await verifyLoginScreenTranslations(tester);
        await testInvalidEmail(tester);
        await testEmptyEmail(tester);
        await testEmptyPassword(tester);
        await loginWithValidCredentials(tester);
      },
    );
  });
}
