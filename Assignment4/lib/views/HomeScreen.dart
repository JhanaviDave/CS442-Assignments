// Jhanavi Dave (A20515346)
import 'package:battleships/views/BattleShipApp.dart';
import 'package:battleships/views/GameAgainstAI.dart';
import 'package:battleships/views/LoginScreen.dart';
import 'package:battleships/views/OngoingGamesPage.dart';
import 'package:flutter/material.dart';

// home screen shows menu options to play new game with opponent, with AI, see ongoing games, and logout
class HomeScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BattleShipApp(),
                  ),
                );
              },
              child: const Text('New Game with Human Opponent'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameAgainstAI(),
                  ),
                );
              },
              child: const Text('New Game with AI Opponent'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OngoingGamesPage(),
                  ),
                );
              },
              child: const Text('Ongoing Games'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
