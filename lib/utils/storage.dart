import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task.dart';

class LocalStorage {
  static const String _tasksKey = 'tasks';
  static const String _isDarkThemeKey = 'theme';

  static Future<void> saveTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final savedTasks = prefs.getStringList(_tasksKey) ?? [];
    final formattedTask = jsonEncode(task);

    await prefs.setStringList(_tasksKey, [...savedTasks, formattedTask]);
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final formattedTasks = tasks.map((task) => jsonEncode(task)).toList();
    await prefs.setStringList(_tasksKey, formattedTasks);
  }

  static Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? tasksJson = prefs.getStringList(_tasksKey);

    if (tasksJson == null) {
      return [];
    }

    return tasksJson.map((task) => Task.fromJson(jsonDecode(task))).toList();
  }

  static Future<void> saveTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkThemeKey, isDarkTheme);
  }

  static Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkThemeKey) ?? false;
  }
}
