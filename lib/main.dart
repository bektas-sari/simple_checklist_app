import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const ChecklistApp());
}

class ChecklistApp extends StatelessWidget {
  const ChecklistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Checklist',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.blue.shade50,
      ),
      home: const ChecklistHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChecklistHomePage extends StatefulWidget {
  const ChecklistHomePage({super.key});

  @override
  State<ChecklistHomePage> createState() => _ChecklistHomePageState();
}

class _ChecklistHomePageState extends State<ChecklistHomePage> {
  final List<TaskItem> tasks = [
    TaskItem(title: "Check emails"),
    TaskItem(title: "Walk the dog"),
    TaskItem(title: "Buy groceries"),
    TaskItem(title: "Study Flutter"),
  ];

  String _getFormattedDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, MMM d, y').format(now);
  }

  int _getRemainingTasks() {
    return tasks.where((task) => !task.isDone).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Checklist'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getFormattedDate(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    '${_getRemainingTasks()} tasks left',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: tasks.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return CheckboxListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration:
                            task.isDone ? TextDecoration.lineThrough : null,
                        color: task.isDone ? Colors.grey : Colors.black,
                      ),
                    ),
                    value: task.isDone,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        task.isDone = value!;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskItem {
  final String title;
  bool isDone;

  TaskItem({required this.title, this.isDone = false});
}
