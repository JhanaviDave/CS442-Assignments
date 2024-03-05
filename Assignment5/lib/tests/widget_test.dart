//Jhanavi Dave (A20515346)
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/screens/home_screen.dart';
import 'package:mp5/screens/login_screen.dart';

void main() {
  testWidgets('HomeScreen UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    //  testWidgets('AuthenticationWrapper renders LoginScreen if not authenticated',
    (WidgetTester tester) async {
      // set authentication as false, since user hasnt logged in
      const isAuthenticated = false;

//checking credentials and launch login
      await tester.pumpWidget(
        const MaterialApp(
          //load page since user is authenticated
          home: AuthenticationWrapper(isAuthenticated: isAuthenticated),
        ),
      );

      // verify that login screen is visivle
      expect(find.byType(LoginScreen), findsOneWidget);
    };

// test widget to check if home screen is authenticatd
    testWidgets('AuthenticationWrapper renders HomeScreen if authenticated',
        (WidgetTester tester) async {
      // set authentication as true, since already logged in
      const isAuthenticated = true;

      // launch homescreen
      await tester.pumpWidget(
        const MaterialApp(
          // launch home screen since user is authenticated
          home: AuthenticationWrapper(isAuthenticated: isAuthenticated),
        ),
      );

      // verify that home screen is visible
      expect(find.byType(HomeScreen), findsOneWidget);
    });
    expect(
        find.text(
            'Welcome! Today is a good day to get some work done under your belt!'),
        findsOneWidget);
  });
}

class AuthenticationWrapper extends StatelessWidget {
  final bool isAuthenticated;

  const AuthenticationWrapper({
    super.key,
    required this.isAuthenticated,
  });

  @override
  Widget build(BuildContext context) {
    // is user logged in? yes - go to home screen, no - stay on login screen
    return isAuthenticated ? const HomeScreen() : const LoginScreen();
  }
}
