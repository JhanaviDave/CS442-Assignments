import 'dart:math';

import 'package:flutter/material.dart';

class Yahtzee extends StatefulWidget {
  @override
  _YahtzeeGameState createState() =>
      _YahtzeeGameState(); // creating game state for each new game instance
}

class _YahtzeeGameState extends State<Yahtzee> {
  bool containsAll(List<int> list, List<int> elements) {
    // boolean to check if the dice values are from the list of sequence
    for (var element in elements) {
      if (!list.contains(element)) {
        // if not in sequence, return false, fill emoty value for category
        return false;
      }
    }
    return true;
  }

  bool _scoreRegistered =
      false; //has the score been registered in the scorecard

  List<int> diceValues = [
    1,
    1,
    1,
    1,
    1
  ]; // initial values of dice, when game round starts
  List<bool> diceHeld = [
    false,
    false,
    false,
    false,
    false
  ]; // any die hasnt been held in the beginning to keep the state new
  int totalScore = 0; // total final score

  int rollsRemaining = 3; // total number of rolls remaining in each round

  int ones = 0,
      twos = 0,
      threes = 0,
      fours = 0,
      fives = 0,
      sixes = 0,
      fullhouse = 0,
      smallStraight = 0,
      largeStraight = 0,
      chance = 0,
      yahtzee = 0,
      fourkind = 0,
      threekind = 0; // initializing all scoreboard values

  void rollDice() {
    //function to decide action when dice is rolled
    if (rollsRemaining > 0) {
      // out of 3, how many rolls are left for the particular round
      setState(() {
        // save state of dice rolled
        rollsRemaining--; // reduce number of rolls left by one
        if (diceHeld.every((held) => held == true)) {
          // are all dices held? then reset the round
          diceValues = [1, 1, 1, 1, 1]; // initialize dice values
          diceHeld = [
            false,
            false,
            false,
            false,
            false
          ]; //remove all holds from dice
          rollsRemaining = 3; // reset number of rolls remaining to 3
        } else {
          // if any die/dice is unheld, rolls them
          for (var i = 0; i < diceValues.length; i++) {
            // for each dice
            if (!diceHeld[i]) {
              // if it is unheld
              diceValues[i] = Random().nextInt(6) +
                  1; // roll to give a random number from 1 to 6
            }
          }
        }
      });
    }
  }

  void registerScore() {
    // save and register score of the dice
    setState(() {
      // save state
      _scoreRegistered =
          true; // change boolean of score being registered to true
    });
  }

  void resetGameState() {
    // reset game with Reset button
    setState(() {
      // save state as follows
      diceValues = [1, 1, 1, 1, 1]; //initialize dice values
      diceHeld = [false, false, false, false, false]; // remove all holds
      totalScore = 0; // total score of the game is 0, resetting the final score
      rollsRemaining = 3; // number of rolls remaining is 3, since it is reset
      ones = 0; // category for scoring only ones
      twos = 0; // category for scoring only twos
      threes = 0; // category for scoring only threes
      fours = 0; // category for scoring only fours
      fives = 0; // category for scoring only fives
      sixes = 0; // category for scoring only sixes
      fullhouse = 0; // category for scoring full house
      smallStraight = 0; // category for scoring small straight
      largeStraight = 0; // category for scoring large straight
      chance = 0; // category for scoring chance value
      yahtzee = 0; // category for scoring a yahtzee
      fourkind = 0; // category for scoring four of a kind
      threekind = 0; // category for scoring three of a kind
      _scoreRegistered =
          false; // score registered in the game is not true, since game was reset
    });
  }

  void calculateTotalScore() {
    // calculate final score
    int currentRoundScore = diceValues.fold(0, (tot, value) {
      //current round score  is equal of value of dice after roll
      return diceHeld[diceValues.indexOf(value)]
          ? tot + value
          : tot; // return the total of dices held as score for the round
    });
    totalScore += currentRoundScore; // current score is added to final scoer

    Map<int, int> occurrences =
        {}; // count occurences of the dice value in each roll
    for (int value in diceValues) {
      occurrences[value] =
          (occurrences[value] ?? 0) + 1; // is the number repeating?
    }

    ones = diceValues.where((value) => value == 1).length *
        1; // how many dice contain 1
    twos = diceValues.where((value) => value == 2).length *
        2; // how many dice contain 2
    threes = diceValues.where((value) => value == 3).length *
        3; // how many dice contain 3
    fours = diceValues.where((value) => value == 4).length *
        4; // how many dice contain 4
    fives = diceValues.where((value) => value == 5).length *
        5; // how many dice contain 5
    sixes = diceValues.where((value) => value == 6).length *
        6; // how many dice contain 6
    if (occurrences.containsValue(5)) {
      // if all 5 dice have same value, it is a yahtzee
      yahtzee = 50; // yahtzee score
    } else if (occurrences.containsValue(3)) {
      // if three dice have same value, then it is three of a kind
      threekind++; // add to three of a kind count
    } else if (occurrences.containsValue(4)) {
      // if four dice have same value, then it is four of a kind
      fourkind++; // add to four of a kind count
    }
    final counts = Set<int>.from(
        //map and count the repetition of each dice value from round
        diceValues.map((value) => diceValues
            .where((v) => v == value)
            .length)); // are same value dice repeating? then map
    if (counts.contains(2) && counts.contains(3)) {
      // if a dice value is repeating twice, and the other three dice have same value, it is a full house
      fullhouse = 25; // score for getting a full house
    } else {
      fullhouse = 0;
    }

    final sortedValues = diceValues.toSet().toList()
      ..sort(); // sort all dice values in an increasing sequence of numbers
    final uniqueValues =
        sortedValues.toSet().toList(); //find unique values from the sorted list
    if (uniqueValues.length >=
            4 && // if there are 4 unique values in the list, and if they are in an increasing sequence, score a small straight
        (containsAll(uniqueValues, [1, 2, 3, 4]) ||
            containsAll(uniqueValues, [2, 3, 4, 5]) ||
            containsAll(uniqueValues, [3, 4, 5, 6]))) {
      smallStraight = 30; // score for getting a small straight
    } else {
      smallStraight = 0;
    }
    if (uniqueValues.length ==
            5 && // if there are 5 unique values in the list, and if they are in an increasing sequence, score a large straight
        (containsAll(uniqueValues, [1, 2, 3, 4, 5]) ||
            containsAll(uniqueValues, [2, 3, 4, 5, 6]))) {
      largeStraight = 40; // score for getting a large straight
    } else {
      largeStraight = 0;
    }
    chance = diceValues.reduce((tot, value) =>
        tot + value); // add all dice values to get a chance value
  }

  @override
  Widget build(BuildContext context) {
    // build/display of the game
    return Scaffold(
      // occupy available space
      appBar: AppBar(
        title: Text('Yahtzee'), // name of the app
      ),
      backgroundColor: Color.fromARGB(255, 196, 121, 24), // background color
      body: SingleChildScrollView(
        // scroll enabled
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // center align all
          children: <Widget>[
            Text(
              'Dice for the Game of Yahtzee:', // name of the game on screen
              style: TextStyle(fontSize: 15), // set font size of game to 15
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < 5; i++) // for 5 dice
                  GestureDetector(
                    // detect action on screen
                    onTap: () {
                      setState(() {
                        diceHeld[i] = !diceHeld[
                            i]; // is dice held? save state for another roll
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // display 5 dice boxes
                        color: diceHeld[i]
                            ? Colors.brown
                            : Colors
                                .grey, // if dice is held, color is brown, else unheld dice is grey
                        borderRadius:
                            BorderRadius.circular(10), //rounded borders
                      ),
                      child: Center(
                        child: Text(
                          diceValues[i].toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black), // dice value color
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: rollDice, // roll dice with button
              child: Text(rollsRemaining > 0
                  ? 'Roll Dice'
                  : 'Round Over'), // after three rolls, the round is over
            ),
            SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                // if no rolls are remaining, calculate final score
                if (rollsRemaining == 0) {
                  calculateTotalScore();
                  rollsRemaining =
                      3; // reset the numer of remainign rolls after calculating final score for new round
                  setState(() {
                    diceValues = [1, 1, 1, 1, 1]; // initialize
                    diceHeld = [
                      false,
                      false,
                      false,
                      false,
                      false
                    ]; // initialize
                  });
                }
              },
              child: Text('Calculate All Scores'), // button name
            ),
            SizedBox(height: 15),
            Text(
              'Total Score: $totalScore', // total score displayed
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Ones: $ones', // number of ones
              style: TextStyle(fontSize: 15),
            ),
////////////////////////////////////////

/////////////////////////////////
            Text(
              'Twos: $twos', // number of tows
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Threes: $threes', // number of threes
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Fours: $fours', // number of fours
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Fives: $fives', // number of fives
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Sixes: $sixes', // number of sixes
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Three of a kind: $threekind', // number of three of a kind
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Four of a kind: $fourkind', // number of four of a kind
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Full House: $fullhouse', // display full house score
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Small Straight: $smallStraight', // display small straight score
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Large Straight: $largeStraight', // display large straight score
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Yahtzee: $yahtzee', // display yahtzee score
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Chance: $chance', // display chance score
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: resetGameState, // reste game button
              child: Text('Reset Game'),
            ),
          ],
        ),
      ),
    );
  }
}
