// Jhanavi Dave (A20515346)
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// check for ongoing games
class OngoingGamesPage extends StatefulWidget {
  const OngoingGamesPage({Key? key}) : super(key: key);

  @override
  _OngoingGamesPageState createState() => _OngoingGamesPageState();
}

class _OngoingGamesPageState extends State<OngoingGamesPage> {
  List<String> ongoingGames = [];

  @override
  void initState() {
    super.initState();
    fetchOngoingGames();
  }

// fetch all on going games from server for user
  Future<void> fetchOngoingGames() async {
    final response =
        await http.get(Uri.parse('http://165.227.117.48/ongoing-games'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final games = List<String>.from(jsonResponse['games']);
      setState(() {
        ongoingGames = games;
      });
    } else {
      print('Failed to fetch ongoing games');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ongoing Games'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('List of Ongoing Games'),
            if (ongoingGames.isEmpty)
              Text('No games available')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: ongoingGames.length,
                  itemBuilder: (context, index) {
                    final game = ongoingGames[index];
                    return ListTile(
                      title: Text('Game ID: $game'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResumeGamePage(gameId: game),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// resume game if on going with another opponent
class ResumeGamePage extends StatelessWidget {
  final String gameId;
  const ResumeGamePage({Key? key, required this.gameId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Resuming Game $gameId...'),
          ],
        ),
      ),
    );
  }
}
