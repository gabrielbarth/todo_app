import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/api_service.dart';
import 'package:todo_app/utils/storage.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isDarkMode = false;
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isDarkMode => _isDarkMode;
  bool get isLoading => _isLoading;

  void addTask(Task task) async {
    _tasks.add(task);
    notifyListeners();
    await LocalStorage.saveTask(task);
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    await LocalStorage.saveTheme(_isDarkMode);
  }

  void toggleTaskCompletion(Task task) async {
    for (var i = 0; i < _tasks.length; i++) {
      if (_tasks[i].id == task.id) {
        _tasks[i].completed = !_tasks[i].completed;
        notifyListeners();
        break;
      }
    }
    await LocalStorage.saveTasks(_tasks);
  }

  Future<void> fetchTasks(ApiService apiService) async {
    _isLoading = true;
    try {
      _tasks = await LocalStorage.getTasks();
      if (_tasks.isEmpty) {
        _tasks = await apiService.getTasks();
        await LocalStorage.saveTasks(_tasks);
      }
    } catch (e) {
      // ignore: avoid_print
      print("Failed to fetch tasks: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setTheme() async {
    _isDarkMode = await LocalStorage.getTheme();
    notifyListeners();
  }
}
