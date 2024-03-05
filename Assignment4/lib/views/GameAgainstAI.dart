// Jhanavi Dave (A20515346)
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// play game against AI
class GameAgainstAI extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const GameAgainstAI({Key? key});

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

// create board for game against AI
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
  bool isOpponentTurn = false;
  int selectedShipsCount = 0;
  String opponentId = "";

// place 5 ships on board
  void placeShips() {
    Random random = Random();

    for (int shipCount = 0; shipCount < 5; shipCount++) {
      int randomRow = random.nextInt(5);
      int randomCol = random.nextInt(5);

      while (boardState[randomRow][randomCol] == 'S') {
        randomRow = random.nextInt(5);
        randomCol = random.nextInt(5);
      }

      boardState[randomRow][randomCol] = 'S';
    }
  }

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
    if (isOpponentTurn) {
      return;
    }

    String result = await sendMove(row, col);

    setState(() {
      if (result == 'hit') {
        boardState[row][col] = 'H';
      } else if (result == 'miss') {
        boardState[row][col] = 'M';
      } else {
        print('wrong shot');
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      handleOpponentMove();
    });
  }

  void handleOpponentMove() {
    Random random = Random();
    int randomRow = random.nextInt(5);
    int randomCol = random.nextInt(5);

    while (boardState[randomRow][randomCol] == 'H' ||
        boardState[randomRow][randomCol] == 'M') {
      randomRow = random.nextInt(5);
      randomCol = random.nextInt(5);
    }

    String opponentResult =
        boardState[randomRow][randomCol] == 'S' ? 'hit' : 'miss';

    setState(() {
      if (opponentResult == 'hit') {
        boardState[randomRow][randomCol] = 'H';
      } else if (opponentResult == 'miss') {
        boardState[randomRow][randomCol] = 'M';
      }

      isOpponentTurn = false;
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
                          selectedShipsCount--;
                          boardState[row][col] = '';
                        } else if (selectedShipsCount < 5) {
                          selectedShipsCount++;
                          boardState[row][col] = 'S'; // Mark as a ship
                        } else {
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
