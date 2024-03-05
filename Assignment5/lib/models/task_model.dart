//Jhanavi Dave (A20515346)
// create task model
class Task {
  int id;
  String title;
  bool completed;

// required field of a task
  Task({required this.id, required this.title, this.completed = false});

// details from json file
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      completed: json['completed'] ?? false,
    );
  }

  // map new task to json
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
