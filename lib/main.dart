import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preeoh_mobile/ui-elements.dart';

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
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
        child: CupertinoApp(
        theme: const CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: CupertinoColors.systemBlue,
        ),
        builder: Authenticator.builder(),
        home: CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemGrey,
            middle: Text('Preeoh'),
          ),
          bottomNavigationBar: bottomNavigation,
          child: Center(
            child: taskListBuilder,
        ),
        ),
    ));
  }
}
