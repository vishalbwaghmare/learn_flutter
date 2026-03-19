import 'package:flutter/material.dart';
import 'package:flutter_sqlite/models/task.dart';
import 'package:flutter_sqlite/services/database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _task;
  final DatabaseService _databaseService = DatabaseService.instance;

  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    _tasks = await _databaseService.getTasks();
    setState(() {});
  }

  void _refresh() {
    setState(() {
      _loadTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.blue[100],
        actions: [_addTaskButton()],
      ),
      body: _tasks.isEmpty 
        ? Container(
          color: Colors.blue[100],
          child: Center(child: Text("No Task available!")),
          )
        : Container(
        decoration: BoxDecoration(color: Colors.blue[100]),
        child: Column(
          children: [
            SizedBox(height: 50),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: _tasks.isEmpty
                      ? const Center(
                          child: Text(
                            "No task available!!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _tasks.length,
                          itemBuilder: (context, index) {
                            final task = _tasks[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              color: Colors.white,
                              elevation: 2,
                              shadowColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                ),
                                child: ListTile(
                                  minTileHeight: 70,
                                  onLongPress: () {
                                    _databaseService.deleteTask(task.id);
                                    _refresh();
                                  },
                                  title: Text(task.content),
                                  leading: CircleAvatar(
                                    backgroundColor: _getColor(task.id),
                                    child: Icon(
                                      _getTaskIcon(task.content),
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: Checkbox(
                                    value: task.status == 1,
                                    onChanged: (value) async {
                                      await _databaseService.updateTaskStatus(
                                        task.id,
                                        value == true ? 1 : 0,
                                      );
                                      _refresh();
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addTaskButton() {
    return IconButton(
      iconSize: 35,
      icon: Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Add Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _task = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter task",
                  ),
                ),
                const SizedBox(height: 8),
                MaterialButton(
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    if (_task == null || _task!.isEmpty) return;
                    _databaseService.addTask(_task!);
                    setState(() {
                      _task = null;
                    });
                    Navigator.of(context).pop();
                    _refresh();
                  },
                  child: Text("Done", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

IconData _getTaskIcon(String content) {
  content = content.toLowerCase();

  if (content.contains("buy") || content.contains("shop")) {
    return Icons.shopping_cart;
  } else if (content.contains("call")) {
    return Icons.call;
  } else if (content.contains("meeting")) {
    return Icons.calendar_today;
  } else if (content.contains("drink")) {
    return Icons.coffee;
  } else {
    return Icons.task_alt;
  }
}

Color _getColor(int id) {
  return Colors.primaries[id % Colors.primaries.length];
}
