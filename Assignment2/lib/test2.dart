// import 'dart:math';

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: YahtzeeGame(),
//     );
//   }
// }

// class YahtzeeGame extends StatefulWidget {
//   @override
//   _YahtzeeGameState createState() => _YahtzeeGameState();
// }

// class _YahtzeeGameState extends State<YahtzeeGame> {
//   List<int> diceValues = [1, 1, 1, 1, 1]; // Initial dice values
//   List<bool> diceHeld = [
//     false,
//     false,
//     false,
//     false,
//     false
//   ]; // Whether each die is held

//   void rollDice() {
//     setState(() {
//       if (diceHeld.every((held) => held == true)) {
//         // If all dice are held, reset them
//         diceValues = [1, 1, 1, 1, 1];
//         diceHeld = [false, false, false, false, false];
//       } else {
//         // Roll only the unheld dice
//         for (var i = 0; i < diceValues.length; i++) {
//           if (!diceHeld[i]) {
//             diceValues[i] = Random().nextInt(6) + 1;
//           }
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Yahtzee'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Dice Values:',
//               style: TextStyle(fontSize: 20),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 for (int i = 0; i < 5; i++)
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         diceHeld[i] = !diceHeld[i];
//                       });
//                     },
//                     child: Container(
//                       width: 50,
//                       height: 50,
//                       margin: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: diceHeld[i] ? Colors.blue : Colors.grey,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: Text(
//                           diceValues[i].toString(),
//                           style: TextStyle(fontSize: 20, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: rollDice,
//               child: Text('Roll Dice'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'dart:math';

// // import 'package:flutter/material.dart';

// // void main() => runApp(MyApp());

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: YahtzeeGame(),
// //     );
// //   }
// // }

// // class YahtzeeGame extends StatefulWidget {
// //   @override
// //   _YahtzeeGameState createState() => _YahtzeeGameState();
// // }

// // class _YahtzeeGameState extends State<YahtzeeGame> {
// //   List<int> diceValues = [1, 1, 1, 1, 1]; // Initial dice values
// //   List<bool> diceHeld = [
// //     false,
// //     false,
// //     false,
// //     false,
// //     false
// //   ]; // Whether each die is held
// //   int rollCount = 0; // Counter for the number of rolls
// //   int totalScore = 0; // Variable to store the total score

// //   void rollDice() {
// //     setState(() {
// //       if (diceHeld.every((held) => held == true) || rollCount == 3) {
// //         // If all dice are held or reached 3 rolls, calculate the score and reset
// //         totalScore += calculateScore(diceValues);
// //         diceValues = [1, 1, 1, 1, 1];
// //         diceHeld = [false, false, false, false, false];
// //         rollCount = 0;
// //       } else {
// //         // Roll only the unheld dice
// //         for (var i = 0; i < diceValues.length; i++) {
// //           if (!diceHeld[i]) {
// //             diceValues[i] = Random().nextInt(6) + 1;
// //           }
// //         }
// //         rollCount++;
// //       }
// //     });
// //   }

// //   int calculateScore(List<int> values) {
// //     // Calculate the score based on the held dice values
// //     int score = 0;
// //     for (int i = 0; i < values.length; i++) {
// //       if (diceHeld[i]) {
// //         score += values[i];
// //       }
// //     }
// //     return score;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Yahtzee'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Text(
// //               'Dice Values:',
// //               style: TextStyle(fontSize: 20),
// //             ),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: <Widget>[
// //                 for (int i = 0; i < 5; i++)
// //                   GestureDetector(
// //                     onTap: () {
// //                       setState(() {
// //                         diceHeld[i] = !diceHeld[i];
// //                       });
// //                     },
// //                     child: Container(
// //                       width: 50,
// //                       height: 50,
// //                       margin: EdgeInsets.all(10),
// //                       decoration: BoxDecoration(
// //                         color: diceHeld[i] ? Colors.blue : Colors.grey,
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       child: Center(
// //                         child: Text(
// //                           diceValues[i].toString(),
// //                           style: TextStyle(fontSize: 20, color: Colors.white),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //               ],
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: rollCount < 3 ? rollDice : null,
// //               child: Text('Roll Dice'),
// //             ),
// //             SizedBox(height: 20),
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
