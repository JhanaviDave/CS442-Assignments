//Jhanavi Dave (A20515346)

import 'dart:async';

import 'package:mp3/views/decklist.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// database helper to translate data from json to sql
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    final path = join(await getDatabasesPath(), 'flashcards_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

// create new flashcard deck
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE flashcard_decks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT
      )
    ''');
    // commit sql command
    await db.execute('''
      CREATE TABLE flashcards(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        deck_id INTEGER,
        question TEXT,
        answer TEXT
      )
    ''');
  }

// delete deck
  Future<void> deleteDeck(int deckId) async {
    final db = await database;
    await db.delete('flashcard_decks', where: 'id = ?', whereArgs: [deckId]);
    await db.delete('flashcards', where: 'deck_id = ?', whereArgs: [deckId]);
  }

// update changes made to deck
  Future<void> updateDeck(int deckId, FlashcardDeck updatedDeck) async {
    final db = await database;
    await db.update(
      'flashcard_decks',
      updatedDeck.toMap(),
      where: 'id = ?',
      whereArgs: [deckId],
    );
    await db.delete('flashcards', where: 'deck_id = ?', whereArgs: [deckId]);
    for (var flashcard in updatedDeck.flashcards) {
      await insertFlashcard(flashcard, deckId);
    }
  }

// add new deck
  Future<int> insertDeck(FlashcardDeck deck) async {
    final db = await database;
    return await db.insert('flashcard_decks', deck.toMap());
  }

// add new flashcard
  Future<int> insertFlashcard(Flashcard flashcard, int deckId) async {
    final db = await database;
    final flashcardData = flashcard.toMap()..['deck_id'] = deckId;
    return await db.insert('flashcards', flashcardData);
  }

// generate map list of flashcards and deck
  Future<List<FlashcardDeck>> getDecks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('flashcard_decks');
    return List.generate(maps.length, (i) {
      return FlashcardDeck(
          title: maps[i]['title'],
          flashcards: [] // Provide the list of flashcards here.
          );
    });
  }

// generate list of flashcards
  Future<List<Flashcard>> getFlashcards(int deckId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('flashcards', where: 'deck_id = ?', whereArgs: [deckId]);
    return List.generate(maps.length, (i) {
      return Flashcard(
        question: maps[i]['question'],
        answer: maps[i]['answer'],
      );
    });
  }
}
