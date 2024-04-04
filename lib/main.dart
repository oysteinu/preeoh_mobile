import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';
import 'screens/task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var env = const String.fromEnvironment("ENV");

  await configureAmplify(env);
  runApp(const PreeohApp());
}

Future<void> configureAmplify(String env) async {
  final auth = AmplifyAuthCognito();

  if (env == "web-local") {}

  try {
    await Amplify.addPlugins([auth]);
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('Failed to configure Amplify: $e');
  }
}

class PreeohApp extends StatelessWidget {
  const PreeohApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Authenticator(
        child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (ctx) => const TaskScreen(),
        // Add more routes if needed
      },
      theme: ThemeData(useMaterial3: true),
      builder: Authenticator.builder(),
    ));
  }
}
