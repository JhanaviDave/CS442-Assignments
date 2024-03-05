//Jhanavi Dave (A20515346)
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:integration_test/integration_test.dart';
import 'package:mp5/main.dart' as app;

// integration testing, added to main file
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration Test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('Welcome to the Home Screen!'), findsOneWidget);
  });
}
