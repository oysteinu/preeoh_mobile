import 'package:flutter/material.dart';
import 'package:preeoh_mobile/preeohapi.dart';

import 'data.dart';

var taskListBuilder = FutureBuilder<List<Task>>(
  future: getTasks(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // until data is fetched, show loader
      return const CircularProgressIndicator();
    } else if (snapshot.hasData) {
      // once data is fetched, display it on screen (call buildPosts())
      final tasks = snapshot.data!;
      return buildTasks(tasks);
    } else {
      // if no data, show simple Text
      return const Text("No data available");
    }
  },
);

Widget buildTasks(List<Task> tasks) {
  // ListView Builder to show data in a list
  return ListView.builder(
    itemCount: tasks.length,
    itemBuilder: (context, index) {
      final task = tasks[index];
      return Container(
        color: Colors.grey.shade300,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: 100,
        width: double.maxFinite,
        child: Row(
          children: [
            /*Expanded(flex: 1, child: Image.network(post.url!)),*/
            /*SizedBox(width: 10),*/
            Expanded(flex: 3, child: Text(task.title!)),
          ],
        ),
      );
    },
  );
}

var securityBuilder = FutureBuilder<String>(
  future: fetchIdToken(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // until data is fetched, show loader
      return const CircularProgressIndicator();
    } else if (snapshot.hasData) {
      // once data is fetched, display it on screen (call buildPosts())
      final jwt = snapshot.data!;
      return buildSecurity(jwt);
    } else {
      // if no data, show simple Text
      return const Text("No data available");
    }
  },
);

Widget buildSecurity(String jwt) {
  return SelectableText(jwt);
}

var appPages = [
  taskListBuilder,
  securityBuilder
];
