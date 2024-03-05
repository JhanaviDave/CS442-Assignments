//Jhanavi Dave (A20515346)
import 'package:flutter/material.dart';
import 'package:mp5/models/user_model.dart';
import 'package:mp5/screens/home_screen.dart';
import 'package:mp5/screens/register_screen.dart';
import 'package:mp5/screens/user_database.dart';

// login credentials page
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // title of app on login screen
      appBar: AppBar(title: const Text('TaskBlast!')),
      body: Center(
        child: Container(
          // box to enter login details
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                // text field to enter username
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                // give highlighted effect
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                // text field to enter password
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 16),
              // button to login
              ElevatedButton(
                onPressed: () {
                  loginUser();
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 8),
              // button to register new
              TextButton(
                onPressed: () {
                  // redirect to register page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text('Register'),
              ),
              const SizedBox(height: 8),
              // if username/password invalid, display error message in red
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    String username = usernameController.text;
    String password = passwordController.text;

// check authentication
    if (username.isNotEmpty && password.isNotEmpty) {
      User? user = await UserDatabase.getUser();

      if (user != null &&
          user.username == username &&
          user.password == password) {
        // redirect to home screen if authenticated
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // error message for wrong credentials
        setState(() {
          errorMessage = 'Invalid username or password';
        });
      }
    } else {
      // error message if field is empty
      setState(() {
        errorMessage = 'Please enter both username and password';
      });
    }
  }
}
