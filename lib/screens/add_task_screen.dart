import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Task Title"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  final newTask = Task(
                    id: Random().nextInt(100),
                    title: _controller.text,
                  );
                  Provider.of<TaskProvider>(context, listen: false)
                      .addTask(newTask);
                  Navigator.pop(context, newTask);
                }
              },
              child: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
