// Jhanavi Dave (A20515346)
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// game page for playing with opponent
class BattleShipApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const BattleShipApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 8),
              const Text('Battleship Game'),
            ],
          ),
        ),
        body: const BattleshipBoard(),
      ),
    );
  }
}

class BattleshipBoard extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const BattleshipBoard({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _BattleshipBoardState createState() => _BattleshipBoardState();
}

class _BattleshipBoardState extends State<BattleshipBoard> {
  List<List<String>> boardState =
      List.generate(5, (index) => List.filled(5, ''));

  bool isPlaying = false;
  int selectedShipsCount = 0;
  String opponentId = "";

  void placeShips() {
    Random random = Random();

    for (int shipCount = 0; shipCount < 5; shipCount++) {
      int randomRow = random.nextInt(5);
      int randomCol = random.nextInt(5);

      // check if the cell already has a ship
      while (boardState[randomRow][randomCol] == 'S') {
        randomRow = random.nextInt(5);
        randomCol = random.nextInt(5);
      }

      // place ship
      boardState[randomRow][randomCol] = 'S';
    }
  }

// connect to api for opponent
  Future<void> pairWithOpponent() async {
    final response = await http.get(Uri.parse('http://165.227.117.48/'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        opponentId = jsonResponse['id'];
        isPlaying = true;
      });
    } else {
      throw Exception('Failed to pair with an opponent');
    }
  }

// update next move
  Future<String> sendMove(int row, int col) async {
    final response = await http.post(
      Uri.parse('http://165.227.117.48/move'),
      body: json.encode({'opponentId': opponentId, 'row': row, 'col': col}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['result'];
    } else {
      throw Exception('Failed to send move');
    }
  }

  void handleMove(int row, int col) async {
    String result = await sendMove(row, col);

    // update game state after each move
    setState(() {
      if (result == 'hit') {
        // mar if ship is hit
        boardState[row][col] = 'H';
      } else if (result == 'miss') {
        // mark if ship is missed
        boardState[row][col] = 'M';
      } else {
        print('wrong shot');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Tap to toggle ship presence',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            height: 300,
            child: GridView.builder(
              // build 5x5 board
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 5;
                int col = index % 5;

                return GestureDetector(
                  onTap: () {
                    if (!isPlaying) {
                      setState(() {
                        if (boardState[row][col] == 'S') {
                          // user searches ship
                          selectedShipsCount--;
                          boardState[row][col] = '';
                        } else if (selectedShipsCount < 5) {
                          // user selects ship
                          selectedShipsCount++;
                          // mark cell as ship
                          boardState[row][col] = 'S';
                        } else {
                          // 5 ships done, no more cells can be selected
                          return;
                        }
                      });
                    } else {
                      handleMove(row, col);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: getColorForCell(row, col),
                    ),
                    child: Center(
                      child: Text(
                        getSymbolForCell(row, col),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 25,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // place ships and save state to start game
              if (!isPlaying && selectedShipsCount == 5) {
                await pairWithOpponent();
                placeShips();
              }
            },
            child: const Text('Start Game'),
          ),
        ],
      ),
    );
  }

  Color getColorForCell(int row, int col) {
    if (boardState[row][col] == 'H') {
      return Colors.red;
    } else if (boardState[row][col] == 'M') {
      return Colors.grey;
    } else if (boardState[row][col] == 'S') {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  String getSymbolForCell(int row, int col) {
    if (boardState[row][col] == 'H') {
      return 'H';
    } else if (boardState[row][col] == 'M') {
      return 'M';
    } else if (boardState[row][col] == 'S') {
      return 'S';
    } else {
      return '';
    }
  }
}
