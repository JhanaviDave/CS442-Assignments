//Jhanavi Dave (A20515346)
import 'package:flutter/material.dart';
import 'package:mp5/screens/home_screen.dart';
import 'package:mp5/screens/login_screen.dart';
// http://192.168.4.26:3000/ and http://127.0.0.1:3000/ is the restpi link - run instruction
// run instruction - run command prompt as admin, cd to current folder, execute json-server --watch db.json for login details and registering new

void main() {
  runApp(const MaterialApp(
    // app name
    title: 'TaskBlast!',
    home: AuthenticationWrapper(),
  ));
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // check if user logged in and authenticated
    bool isAuthenticated = false;

    // is user logged in? yes - go to home screen, no - stay on login screen
    // ignore: dead_code
    return isAuthenticated ? const HomeScreen() : const LoginScreen();
  }
}
