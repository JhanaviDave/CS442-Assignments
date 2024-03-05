//Jhanavi Dave (A20520346)
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mp3/views/DatabaseHelper.dart';

// class to view list of Decks from json (to local database)
class DeckList extends StatefulWidget {
  @override
  //create state to view Deck
  _Deck createState() => _Deck();
}

//state class to view deck list
class _Deck extends State<DeckList> {
  // count number of decks
  int deckCount = 1;
  // get number of decks as list
  List<FlashcardDeck> decks = [];

// edit and save deck's new name and save newly created deck name
  void saveDeckName(String deckName) async {
    // call local database
    final dbHelper = DatabaseHelper.instance;

    // create new deck
    final newDeck = FlashcardDeck(title: deckName, flashcards: []);

    // save to lcaol database, wait to save data
    int deckId = await dbHelper.insertDeck(newDeck);

    // update on main screen with newly created deck and save state
    setState(() {
      decks.add(newDeck);
    });
  }

  @override
  void initState() {
    // initialize state to load deck to home pafe
    super.initState();
// call to load deck data fucntion
    _loadDecks();
  }

// loading decks from local database
  _loadDecks() async {
    // get flashcard data from json to local databse
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/flashcards.json');

// create a list to load deck details from json to local database
    List<dynamic> decksJson = jsonDecode(jsonString);

    // initialize the helper
    final dbHelper = DatabaseHelper.instance;

// for each flashcard/deck title, show detail
    for (var deckJson in decksJson) {
      // save to local variable deck with detail of deckname
      FlashcardDeck deck = FlashcardDeck.fromJson(deckJson);
      int deckId = await dbHelper.insertDeck(deck);

// local variable to store flashcard detail
      for (var flashcard in deck.flashcards) {
        await dbHelper.insertFlashcard(flashcard, deckId);
      }

      // add deck details to database
      decks.add(deck);
// bookmark to check if deck load is successful
      print('Deck ${deck.title}' + " loaded successfully!");
    }
    // save state
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title of application
        title: const Text('Let\'s Study!'),

        actions: <Widget>[
          IconButton(
            // + button to add new deck
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                // increment count of number of decks when pressed
                deckCount++;
              });
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // calculate and distribute size according to app size
          int crossAxisCount = (constraints.maxWidth / 250).floor();

          return GridView.count(
            crossAxisCount: crossAxisCount,
            padding: const EdgeInsets.all(4),
            children: List.generate(
              // generate number of tiles based on number of decks in local datbase
              deckCount,
              (index) => Card(
                color: Colors.purple[100],
                child: Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          {
                            // when deck tile is clicked, go to flashcard page, if deck is not empty
                            if (decks.isNotEmpty && index < decks.length) {
                              // bookmark
                              print('Deck ${index + 1} opened');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      //load flashcards for particular deck
                                      FlashCardPage(deck: decks[index]),
                                ),
                              );
                            } else {
                              // throw error if no deck found
                              print('Invalid deck index: $index');
                            }
                          }
                        },
                      ),
                      //name of deck
                      Center(child: Text('Deck ${index + 1}')),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          // edit button to change deck name / delete deck
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  // call editdeckname function
                                  return const EditDeckName();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////// EDIT DECK NAME ///////////////////////////////////////////////////////////////
class DeckCard {
  //get deck title
  final String title;

  DeckCard({required this.title});

// display deck title on flashcard page
  factory DeckCard.fromJson(Map<String, dynamic> json) {
    return DeckCard(
      title: json['title'],
    );
  }
}

// edit deck name class
class EditDeckName extends StatefulWidget {
  const EditDeckName({Key? key}) : super(key: key);

  @override
  _EditDeckNameState createState() => _EditDeckNameState();
}

// create state to edit deck name or delete deck in local database
class _EditDeckNameState extends State<EditDeckName> {
  final TextEditingController _deckNameController = TextEditingController();

  void deleteDeck() {
    // delete deck from loacl databse
  }

  void saveDeckName() {
    // get deck name
    String deckName = _deckNameController.text;
    // if new deck name is not empty, change to new name and save to lcoal database
    if (deckName.isNotEmpty) {
      final parent = context.findAncestorStateOfType<_Deck>();
      // call parent deck to save title
      parent?.saveDeckName(deckName);
    }
    // delete old deck name
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // page title
        appBar: AppBar(title: const Text('Edit Deck Name')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                // current deck title
                'Deck Name',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              TextField(
                // controller to get new deck name and make changes accordingly
                controller: _deckNameController,
                decoration: const InputDecoration(
                  labelText: 'New Deck Name',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // svae button to save deck detail
                  saveDeckName();
                },
                child: const Text('Save Deck Name'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // delete button to delete deck
                  deleteDeck();
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              ),
              TextButton(
                onPressed: () {
                  //go back to main screen if user wants to cancel operation
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////// FLASH CARD DECK ///////////////////////////////////////////////////////////////

// flash card deck
class FlashcardDeck {
  final String title;
  final List<Flashcard> flashcards;

  FlashcardDeck({required this.title, required this.flashcards});

// map for flashcard title
  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }

// load flashcard/deck title from json
  factory FlashcardDeck.fromJson(Map<String, dynamic> json) {
    return FlashcardDeck(
      title: json['title'],
      flashcards: (json['flashcards'] as List)
          .map((flashcardJson) => Flashcard.fromJson(flashcardJson))
          .toList(),
    );
  }
}

// load flashcard details
class Flashcard {
  String question;
  String answer;

  Flashcard({
    required this.question,
    required this.answer,
  });

// map flashcard details
  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }

// load flashcard details from json
  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      question: json['question'],
      answer: json['answer'],
    );
  }
}

//create state for flashcards
class FlashCardPage extends StatefulWidget {
  const FlashCardPage({Key? key, required this.deck}) : super(key: key);
  final FlashcardDeck deck;

  @override
  _FlashCardPageState createState() => _FlashCardPageState();
}

// create state to load flashcard from local databse
class _FlashCardPageState extends State<FlashCardPage> {
  // list of flaschards
  List<int> flashcardOrder = [];
  // list of new flashcards that are to be added
  List<Flashcard> newFlashcards = [];
  // cuurent flashcard number
  int currentFlashcardIndex = 0;
  //count number for viewed answer
  bool showAnswer = false;
  // flashcard count if newly added flashcard to deck in lcoal database
  int deckCount = 1;
  // count number of times answer was vieweed
  int showAnsCount = 0;
  // if the list of flashcard alphabetically sorted
  bool sortAlphabetically = false;

  @override
  // initialize state to view flashcards
  void initState() {
    super.initState();
    // generate lsit of flashcards with index
    flashcardOrder =
        List.generate(widget.deck.flashcards.length, (index) => index);
  }

// sort flashcards alphabetically v/s descending manner
  void sortFlashcards() {
    // are flashcards sorted alphabetically
    if (sortAlphabetically) {
      flashcardOrder.sort((a, b) {
        // return true if a is before b / alphabetically sotred
        return widget.deck.flashcards[a].question
            .compareTo(widget.deck.flashcards[b].question);
      });
    } else {
      // lsit is in descending/ LIFO manner
      flashcardOrder =
          List.generate(widget.deck.flashcards.length, (index) => index);
    }
  }

// add new flashcard
  void addNewFlashcard() {
    setState(() {
      // take question and answrr and add to flashcard list
      newFlashcards
          .add(Flashcard(question: "New Question", answer: "New Answer"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deck.title),
        actions: <Widget>[
          IconButton(
            // quiz icon
            icon: const Icon(Icons.quiz),
            onPressed: () {
              setState(() {
                // go to quiz page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(deck: widget.deck),
                  ),
                );
              });
            },
          ),
          IconButton(
            // sort alphabetically v/s descending manner
            icon: Icon(sortAlphabetically ? Icons.sort_by_alpha : Icons.sort),
            onPressed: () {
              setState(() {
                // check if soeted alphabetically
                sortAlphabetically = !sortAlphabetically;
                // call to sort flashcards
                sortFlashcards();
                currentFlashcardIndex = 0;
              });
            },
          ),
          IconButton(
            // add new flashcard
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                addNewFlashcard();
                deckCount++; // Increment the flashcard count
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // show current flashcard question
            Text(widget.deck.flashcards[flashcardOrder[currentFlashcardIndex]]
                .question),
            // if showAnswer button is clicked, show flashcard answer
            if (showAnswer)
              Text(widget.deck.flashcards[flashcardOrder[currentFlashcardIndex]]
                  .answer),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // show answer button, change boolean to true since it was clicked
                  showAnswer = true;
                  // add to answers viewed count
                  showAnsCount++;
                });
              },
              child: const Text('Show Answer'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // go to next flashcard and dont reveal answer
                  showAnswer = false;
                  //next flashcard index
                  currentFlashcardIndex++;
                  // if reached end, go to first index
                  if (currentFlashcardIndex >= flashcardOrder.length) {
                    currentFlashcardIndex = 0;
                  }
                });
              },
              child: const Text('Next Card'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // previous flashcard button and hide answer
                  showAnswer = false;
                  currentFlashcardIndex--;
                  // reached last going back, then jump to first flashcard
                  if (currentFlashcardIndex < 0) {
                    currentFlashcardIndex = 0;
                  }
                });
              },
              child: const Text('Previous Card'),
            ),
            // show count of answers viewed
            Text('Number of Answers Viewed: $showAnsCount'),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////// QUIZ DECK ///////////////////////////////////////////////////////////////

// create state for quiz on particular deck
class QuizPage extends StatefulWidget {
  final FlashcardDeck deck;

  QuizPage({Key? key, required this.deck}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

// create state to load quiz for deck
class _QuizPageState extends State<QuizPage> {
  // initialize current flashcard index
  int currentFlashcardIndex = 0;
  // list of flashcards in order (randomly generated later)
  List<int> flashcardOrder = [];
  // if answer is viewed
  bool showAnswer = false;
// count for number of answers viewed
  int showAnsCount = 0;
  // how many flashcards were viewed in total
  int viewedFlashcardsCount = 0;

  @override
  // initialzie state to load flashcards
  void initState() {
    super.initState();
    flashcardOrder =
        // generate list of flashcards
        List.generate(widget.deck.flashcards.length, (index) => index);
    // generate in random order
    flashcardOrder.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // quiz for particualr deck
        title: Text(widget.deck.title + " Quiz"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // question of flashcard
            Text(widget.deck.flashcards[flashcardOrder[currentFlashcardIndex]]
                .question),
            // if showanswer button clicked, reveal answer
            if (showAnswer)
              Text(widget.deck.flashcards[flashcardOrder[currentFlashcardIndex]]
                  .answer),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // show answer button, click to reveal answer and increase count of viewed answers
                  showAnswer = true;
                  showAnsCount++;
                });
              },
              child: const Text('Show Answer'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // next flashcard from randomized order
                  showAnswer = false;
                  currentFlashcardIndex++;
                  if (currentFlashcardIndex >= flashcardOrder.length) {
                    currentFlashcardIndex = 0;
                    flashcardOrder.shuffle();
                  }
                  viewedFlashcardsCount++;
                });
              },
              child: const Text('Next Card'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // previous flashcard from order
                  currentFlashcardIndex--;
                  if (currentFlashcardIndex < 0) {
                    currentFlashcardIndex = 0;
                  }
                });
              },
              child: const Text('Previous Card'),
            ),
            // count of answers viewed
            Text('Number of Answers Viewed: $showAnsCount'),
            // number of flashcards viewed
            Text('Number of FlashCards Viewed: $viewedFlashcardsCount'),
          ],
        ),
      ),
    );
  }
}
