class Task {
  final int id;
  final String title;
  bool completed;

  Task({required this.id, required this.title, this.completed = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
