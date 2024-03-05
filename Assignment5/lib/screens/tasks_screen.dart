//Jhanavi Dave (A20515346)
import 'package:flutter/material.dart';
import 'package:mp5/models/task_model.dart';
import 'package:mp5/screens/home_screen.dart';
import 'package:mp5/screens/task_database.dart';

// create new task on new page
class NewTaskScreen extends StatelessWidget {
  // actgion ot take when clicked on save button
  final Function(String) onSave;

  const NewTaskScreen({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // textfield to enter task details
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Enter Task'),
            ),
            // save button to create new task on task page
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String newTaskTitle = controller.text;
                onSave(newTaskTitle);
                Navigator.pop(context); // Return to TasksScreen
              },
              child: const Text('Save task'),
            ),
            // cancel and go back to previous page
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> tasks = [];
  // get appcolor as theme color
  Color? appColor;

  @override
  void initState() {
    super.initState();
    fetchTasksFromJson();
  }

  Future<void> fetchTasksFromJson() async {
    List<Task> fetchedTasks = await TaskDatabase.getTasksFromJson();
    setState(() {
      tasks = fetchedTasks;
    });
  }

  void addTask(String title) {
    setState(() {
      tasks.add(Task(id: tasks.length + 1, title: title, completed: false));
    });

    TaskDatabase.saveTasksToJson(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // display all tasks
        title: const Text('Task List'),
        backgroundColor: appColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // back button to go to home screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // checkmark button to select task as done, yet keep visible on screen
                IconButton(
                  icon: Icon(
                    tasks[index].completed
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: tasks[index].completed ? Colors.green : null,
                  ),
                  onPressed: () {
                    setState(() {
                      // change state to done, when tapped
                      tasks[index].completed = !tasks[index].completed;
                    });
                    TaskDatabase.saveTasksToJson(tasks);
                  },
                ),
                // delete task button
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      // when pressed, delete from json
                      tasks.removeAt(index);
                    });
                    TaskDatabase.saveTasksToJson(tasks);
                  },
                ),
              ],
            ),
          );
        },
      ),
      // new task button to create new task, redirects to new task creation page
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTaskScreen(
                onSave: (newTaskTitle) {
                  // save task when clicked on save
                  addTask(newTaskTitle);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
