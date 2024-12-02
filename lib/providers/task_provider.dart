import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isDarkMode = false;

  List<Task> get tasks => _tasks;
  bool get isDarkMode => _isDarkMode;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
