import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/services/api_service.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/add_task_screen.dart';
import '../widgets/task_card.dart';
import '../utils/platform_channel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final apiService = ApiService(Dio());
    Provider.of<TaskProvider>(context, listen: false).fetchTasks(apiService);
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              taskProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: taskProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) =>
                  TaskCard(task: taskProvider.tasks[index]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );

          if (result != null) {
            PlatformChannel.showToast("Task added!");
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
