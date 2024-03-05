// scorecard.dart

class ScoreCard {
  static int calculateTotalScore(List<int> diceValues, List<bool> diceHeld) {
    int currentTurnScore = diceValues.fold(0, (sum, value) {
      return diceHeld[diceValues.indexOf(value)] ? sum + value : sum;
    });
    return currentTurnScore;
  }

  static Map<String, int> calculateCategories(List<int> diceValues) {
    Map<String, int> categories = {
      'yahtzee': 0,
      'fours': 0,
      'threes': 0,
    };

    // Count occurrences of each number in diceValues
    Map<int, int> occurrences = {};
    for (int value in diceValues) {
      occurrences[value] = (occurrences[value] ?? 0) + 1;
    }

    // Check for Yahtzee, Fours, and Threes
    if (occurrences.containsValue(5)) {
      categories['yahtzee'] = 1;
    } else if (occurrences.containsValue(4)) {
      categories['fours'] = 1;
    } else if (occurrences.containsValue(3)) {
      categories['threes'] = 1;
    }

    return categories;
  }
}
