//Jhanavi Dave (A20515346)
import 'dart:convert';
import 'dart:io';

import 'package:mp5/models/task_model.dart';
import 'package:path_provider/path_provider.dart';

// task database
class TaskDatabase {
  static Future<List<Task>> getTasksFromJson() async {
    try {
      // get directory from json file
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      File jsonFile = File('${appDocumentsDirectory.path}/task.json');
      if (jsonFile.existsSync()) {
        // if file exiists, read task list and map to file
        String jsonString = await jsonFile.readAsString();
        Map<String, dynamic> jsonMap = json.decode(jsonString);
        List<dynamic> tasksJson = jsonMap['tasks'];
        List<Task> tasks =
            tasksJson.map((taskJson) => Task.fromJson(taskJson)).toList();
        return tasks;
      }
    } catch (e) {
      return [];
    }
    return [];
  }

// save new task to json
  static Future<void> saveTasksToJson(List<Task> tasks) async {
    try {
      // get directory from json
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      File jsonFile = File('${appDocumentsDirectory.path}/task.json');
      // map new task to json
      List<Map<String, dynamic>> tasksJson =
          tasks.map((task) => task.toMap()).toList();
      Map<String, dynamic> jsonMap = {'tasks': tasksJson};
      // wait to sync to refresh
      await jsonFile.writeAsString(json.encode(jsonMap));
    } catch (e) {
      return;
    }
  }
}
