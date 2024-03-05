// dice.dart
import 'dart:math';

class Dice {
  static List<int> rollDice(List<int> diceValues, List<bool> diceHeld) {
    for (var i = 0; i < diceValues.length; i++) {
      if (!diceHeld[i]) {
        diceValues[i] = Random().nextInt(6) + 1;
      }
    }
    return diceValues;
  }
}
