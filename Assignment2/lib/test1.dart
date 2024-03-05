// // import 'dart:math';

// // import 'package:flutter/material.dart';

// // void main() => runApp(YahtzeeApp());

// // class YahtzeeApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Yahtzee Game',
// //       home: YahtzeeScreen(),
// //     );
// //   }
// // }

// // class YahtzeeScreen extends StatefulWidget {
// //   @override
// //   _YahtzeeScreenState createState() => _YahtzeeScreenState();
// // }

// // class _YahtzeeScreenState extends State<YahtzeeScreen> {
// //   List<int> dice = [1, 2, 3, 4, 5]; // Initialize with default values
// //   Random random = Random();
// //   int totalScore = 0;

// //   void rollDice() {
// //     setState(() {
// //       for (int i = 0; i < dice.length; i++) {
// //         dice[i] = random.nextInt(6) + 1;
// //       }
// //     });
// //   }

// //   void scoreRoll() {
// //     // Implement your scoring logic here
// //     // Update the totalScore variable accordingly
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Yahtzee Game'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Text(
// //               'Rolled Dice: $dice',
// //               style: TextStyle(fontSize: 20),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () {
// //                 rollDice();
// //               },
// //               child: Text('Roll Dice'),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 scoreRoll();
// //               },
// //               child: Text('Score Roll'),
// //             ),
// //             Text(
// //               'Total Score: $totalScore',
// //               style: TextStyle(fontSize: 20),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:math';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(YahtzeeApp());
// }

// class YahtzeeApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Yahtzee Game',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: YahtzeeGame(),
//     );
//   }
// }

// class YahtzeeGame extends StatefulWidget {
//   @override
//   _YahtzeeGameState createState() => _YahtzeeGameState();
// }

// class _YahtzeeGameState extends State<YahtzeeGame> {
//   Random random = Random();
//   List<int> dice = [1, 1, 1, 1, 1];
//   bool canRoll = true;
//   int rollsLeft = 3;
//   int totalScore = 0;

//   void rollDice() {
//     if (rollsLeft > 0) {
//       setState(() {
//         for (int i = 0; i < dice.length; i++) {
//           if (dice[i] != 0) {
//             dice[i] = random.nextInt(6) + 1;
//           }
//         }
//         rollsLeft--;
//         if (rollsLeft == 0) {
//           canRoll = false;
//         }
//       });
//     }
//   }

//   void scoreRoll() {
//     // Implement your scoring logic here.
//     // Calculate the score based on the dice values.
//     int currentScore = 0;
//     // Example scoring: Sum of all dice values
//     currentScore = dice.fold(0, (acc, value) => acc + value);
//     totalScore += currentScore;

//     // Reset dice and rolls for the next turn
//     setState(() {
//       dice = [1, 1, 1, 1, 1];
//       rollsLeft = 3;
//       canRoll = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Yahtzee Game'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Dice: $dice',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Rolls Left: $rollsLeft',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Total Score: $totalScore',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: canRoll ? rollDice : null,
//               child: Text('Roll Dice'),
//             ),
//             ElevatedButton(
//               onPressed: canRoll ? null : scoreRoll,
//               child: Text('Score Roll'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
