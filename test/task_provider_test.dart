import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  group("TaskProvider Tests", () {
    test("Add Task", () {
      final taskProvider = TaskProvider();

      final task = Task(id: 1, title: "Test Task");
      taskProvider.addTask(task);

      expect(taskProvider.tasks.length, 1);
      expect(taskProvider.tasks.first.title, "Test Task");
    });

    test("Toggle Theme", () {
      final taskProvider = TaskProvider();

      final initialTheme = taskProvider.isDarkMode;
      taskProvider.toggleTheme();

      expect(taskProvider.isDarkMode, !initialTheme);
    });
  });
}
