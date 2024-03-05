//Jhanavi Dave (A20515346)
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mp5/models/task_model.dart';
import 'package:mp5/models/user_model.dart';
import 'package:mp5/screens/settings_screen.dart';
import 'package:mp5/screens/tasks_screen.dart';
import 'package:mp5/screens/user_database.dart';
import 'package:table_calendar/table_calendar.dart';

import 'login_screen.dart';

// home page
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Color? appColor;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

// fetch tasks from local host of json
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:3000/tasks'));

// if loaded correctly, read tasks frm json
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        tasks = data.map((task) => Task.fromJson(task)).toList();
      });
    } else {
      // error message if json not loaded
      throw Exception('Failed to load data');
    }

    // get username and theme color registered by user
    User user = await getUserData();
    setState(() {
      appColor = Color(user.appColor);
    });
  }

// get user details
  Future<User> getUserData() async {
    User? user = await UserDatabase.getUser();

// if user details are not provided, for testing, use these credentials
    user ??= User(
      username: 'Guest',
      password: '',
      appColor: 0xFF3498db,
    );

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // app name
        title: const Text('TaskBlast!'),
        backgroundColor: appColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // menu bar with page options
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: appColor,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // view tasks from tiled list in menu
            ListTile(
              title: const Text('Tasks'),
              onTap: () {
                // redirect to task page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const TasksScreen()),
                );
              },
            ),
            // change settings from tiled list in menu
            ListTile(
              title: const Text('Settings'),
              // redirect to settings page for changes
              onTap: () async {
                Color? updatedColor = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );

                if (updatedColor != null) {
                  // update theme color if modified in settings
                  setState(() {
                    appColor = updatedColor;
                  });
                }
              },
            ),
            // logout
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                // go back to login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),

      body: Column(children: [
        Padding(
          // display welcome message
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Welcome! Today is a good day to get some work under the belt!',
            style: TextStyle(fontSize: 18, color: appColor),
          ),
        ),
        // display today's calendar
        TableCalendar(
          // start of calendar
          firstDay: DateTime.utc(1900, 1, 1),
          // end of calnder
          lastDay: DateTime.utc(2099, 12, 31),
          // today's date
          focusedDay: _focusedDay,
          // week and month view
          calendarFormat: _calendarFormat,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
            CalendarFormat.week: 'Week',
          },
          onFormatChanged: (format) {
            setState(() {
              // highlight today
              _calendarFormat = format;
            });
          },
          // is selected date today?
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              // change highlight if today not selected
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
        ),
        // jump back to today's date button
        FloatingActionButton(
          onPressed: () {
            setState(() {
              _selectedDay = DateTime.now();
              _focusedDay = DateTime.now();
            });
          },
          backgroundColor: appColor,
          child: const Icon(
            Icons.today,
            color: Colors.black,
          ),
        ),
      ]),
    );
  }
}
