import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/api_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isDarkMode = false;
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isDarkMode => _isDarkMode;
  bool get isLoading => _isLoading;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  Future<void> fetchTasks(ApiService apiService) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await apiService.getTasks();
    } catch (e) {
      print("Failed to fetch tasks: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
