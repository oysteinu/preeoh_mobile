import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:preeoh_mobile/data.dart';
import 'package:preeoh_mobile/ui-elements.dart';
import 'package:preeoh_mobile/preeohapi.dart';

import 'amplifyconfiguration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(const PreeohApp());
}

Future<void> configureAmplify() async {
  final auth = AmplifyAuthCognito();

  try {
    await Amplify.addPlugins([auth]);
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('Failed to configure Amplify: $e');
  }
}

class PreeohApp extends StatefulWidget {
  const PreeohApp({Key? key}) : super(key: key);

  @override
  State<PreeohApp> createState() => _PreeohAppState();
}

class _PreeohAppState extends State<PreeohApp> {
  String jwt = "NA";
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
    return Authenticator(
        child: MaterialApp(
      theme: ThemeData(useMaterial3: true),
      builder: Authenticator.builder(),
      home: Scaffold(
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
      ),
    ));
  }
}
