// Jhanavi Dave (A20515346)
import 'dart:convert';

import 'package:battleships/views/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// login screen as main screen to login
class LoginScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginScreen({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  String _errorMessage = '';

  void _login() async {
    if (_loading) return;

    setState(() {
      _loading = true;
    });

// get login details
    final response = await http.post(
      Uri.parse('http://165.227.117.48/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

// login if details are correct
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final sessionToken = responseData['sessionToken'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('sessionToken', sessionToken);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password';
        _loading = false;
      });
    }
  }

// register new user
  void _register() async {
    if (_loading) return;

    setState(() {
      _loading = true;
    });

// get user details for registering
    final response = await http.post(
      Uri.parse('http://165.227.117.48/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final sessionToken = responseData['sessionToken'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('sessionToken', sessionToken);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      setState(() {
        _errorMessage = 'Registration failed. Try a different username.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              if (_loading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
              const SizedBox(height: 16.0),
              Text(_errorMessage, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: _register,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
