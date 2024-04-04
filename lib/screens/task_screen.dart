import 'package:flutter/material.dart';

import '../models/task.dart';
import '../preeohapi.dart';
import '../ui-elements.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int selectedNavigationIndex = 0;
  late Future<List<Task>> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = getTasks();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedNavigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            label: 'Security',
          ),
        ],
        currentIndex: selectedNavigationIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: Center(
        //child: taskListBuilder,
        child: [
          FutureBuilder<List<Task>>(
            future: _tasks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                var tasks = snapshot.data!;

                return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        _tasks = getTasks();
                      });
                    },
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];

                        return Container(
                          color: Colors.grey.shade300,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          height: 100,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              /*Expanded(flex: 1, child: Image.network(post.url!)),*/
                              /*SizedBox(width: 10),*/
                              Expanded(flex: 3, child: Text(task.title)),
                            ],
                          ),
                        );
                      },
                    ));
              } else {
                return const Text("No data available");
              }
            },
          ),
          securityBuilder
        ][selectedNavigationIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
