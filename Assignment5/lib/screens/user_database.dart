//Jhanavi Dave (A20515346)
import 'dart:convert';
import 'dart:io';

import 'package:mp5/models/user_model.dart';

// create user database class
class UserDatabase {
  static const String _userFileName = 'user.json';

  // save user details to json
  static Future<void> saveUser(User user) async {
    try {
      // check if user exists
      if (await isUserExistsAsync(user.username)) {
        return;
      }
      // read name of json file
      final File file = File(_userFileName);

      if (file.existsSync()) {
        // read content of file if exists
        final String existingData = await file.readAsString();
        final List<dynamic> userList = json.decode(existingData);

        // append new user to file
        userList.add(user.toMap());

        // save it to json list
        await file.writeAsString(json.encode(userList));
      } else {
        // map the newly added details
        await file.writeAsString(json.encode([user.toMap()]));
      }
    } catch (e) {
      return;
    }
  }

  // check if user exixts in json
  static Future<bool> isUserExistsAsync(String username) async {
    try {
      // read file
      final File file = File(_userFileName);

// if exists, load map from json
      if (file.existsSync()) {
        final String userData = await file.readAsString();
        final List<dynamic> userList = json.decode(userData);

// check existing user name
        return userList.any((userData) {
          final existingUser = User.fromMap(userData);
          return existingUser.username == username;
        });
      }
    } catch (e) {
      return true;
    }

    return false;
  }

  // get user details from json file
  static Future<User?> getUser() async {
    // read json file
    final File file = File(_userFileName);

// is file exist, get user name
    if (file.existsSync()) {
      final String userData = await file.readAsString();
      final List<dynamic> userList = json.decode(userData);

      // if list is not empty, map from jso file
      if (userList.isNotEmpty) {
        final Map<String, dynamic> userMap = userList.last;
        return User.fromMap(userMap);
      }
    }

    return null;
  }

  // clear/delete user details from json
  static Future<void> clearUser() async {
    try {
      final File file = File(_userFileName);

      if (file.existsSync()) {
        await file.delete();
      }
    } catch (e) {
      return;
    }
  }
}
