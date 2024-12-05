import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return MaterialApp(
            theme: taskProvider.isDarkMode ? darkTheme : lightTheme,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
