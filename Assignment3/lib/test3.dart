// import 'dart:math';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(title: 'Yahtzee', home: Yahtzee()
//       // Scaffold(body: Yahtzee()),
//       // Scorecard(),
//       ));
// }

// class Yahtzee extends StatefulWidget {
//   @override
//   _YahtzeeGameState createState() => _YahtzeeGameState();
// }

// class _YahtzeeGameState extends State<Yahtzee> {
//   Random random = Random();
//   List<int> dice = [1, 1, 1, 1, 1]; // initial dice values
//   bool canRoll = true; //
//   int rollsLeft = 3;
//   int totalScore = 0;
//   List<bool> diceHeld = [false, false, false, false, false]; // is the die held?
//   void rollDice() {
//     setState(() {
//       if (diceHeld.every((held) => held == true)) {
//         // If all dice are held, reset them
//         dice = [1, 1, 1, 1, 1];
//         diceHeld = [false, false, false, false, false];
//       } else {
//         // Roll only the unheld dice
//         for (var i = 0; i < dice.length; i++) {
//           if (!diceHeld[i]) {
//             dice[i] = Random().nextInt(6) + 1;
//           }
//         }
//       }
//     });
//   }

//   void Scorecard() {
//     int ones = 0,
//         twos = 0,
//         threes = 0,
//         fours = 0,
//         fives = 0,
//         sixes = 0,
//         threekind = 0,
//         fourkind = 0,
//         fullHouse = 0,
//         smallStraight = 0,
//         largeStraight,
//         yahtzee = 0,
//         chance = 0;

//     int currentScore = 0;
//     currentScore = dice.fold(0, (acc, value) => acc + value);
//     // currentScore++;
//     totalScore += currentScore;
//     setState(() {
//       dice = [1, 1, 1, 1, 1];
//       rollsLeft = 3;
//       rollsLeft--;
//       canRoll = true;
//     });

//     // final List<String> scoreTypes = [
//     //   "Ones:",
//     //   "Twos:",
//     //   "Threes:",
//     //   "Fours:",
//     //   "Fives:",
//     //   "Sixes:",
//     //   "Three of a Kind:",
//     //   "Four of a Kind:",
//     //   "Full House:",
//     //   "Small Straight:",
//     //   "Large Straight:",
//     //   "Yahtzee:",
//     //   "Chance:"
//     // ];
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
//               onPressed: canRoll ? null : Scorecard,
//               child: Text('Score Card'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class Scorecard extends StatelessWidget {
// //   final List<String> playerNames = [
// //     "Ones:",
// //     "Twos:",
// //     "Threes:",
// //     "Fours:",
// //     "Fives:",
// //     "Sixes:",
// //     "Three of a Kind:",
// //     "Four of a Kind:",
// //     "Full House:",
// //     "Small Straight:",
// //     "Large Straight:",
// //     "Yahtzee:",
// //     "Chance:"
// //   ];
// // }
