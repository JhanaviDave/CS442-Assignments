// import 'dart:math';

// import 'package:flutter/material.dart';

// class Yahtzee extends StatefulWidget {
//   // const Yahtzee({super.key});
//   @override
//   _YahtzeeGameState createState() => _YahtzeeGameState();
// }

// class _YahtzeeGameState extends State<Yahtzee> {
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
