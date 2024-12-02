import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(task.title),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            // Handle completion toggle if necessary
          },
        ),
      ),
    );
  }
}
