// Jhanavi Dave (A20515346)
import 'package:flutter/material.dart';

// game logic page for battleships
class GamePage extends StatelessWidget {
  final List<List<String>> boardState;

  const GamePage({Key? key, required this.boardState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battleship Game'),
      ),
      body: Center(
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
                // build 5x5 board for gameplay
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ 5;
                  int col = index % 5;

                  return Container(
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
                  );
                },
                itemCount: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColorForCell(int row, int col) {
    return Colors.grey;
  }

  String getSymbolForCell(int row, int col) {
    return '';
  }
}
