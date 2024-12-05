import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/services/api_service.dart';
import '../providers/task_provider.dart';
import '../screens/add_task_screen.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final apiService = ApiService(Dio());

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<TaskProvider>(context, listen: false);
    provider.fetchTasks(apiService);
    provider.setTheme();
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Task adicionada!'),
              ),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
