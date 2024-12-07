import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});
  final TextEditingController _controller = TextEditingController();

  void _onPressed(context) {
    if (_controller.text.isEmpty) return;

    final newTask = Task(
      id: Random().nextInt(100),
      title: _controller.text,
    );
    Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
    Navigator.pop(context, newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Task Title"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _onPressed(context),
              child: const Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
