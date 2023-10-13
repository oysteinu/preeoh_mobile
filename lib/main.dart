import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';

void main() {
  runApp(const PreeohApp());
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
    _configureAmplify();
  }

  void _configureAmplify() async {
    final auth = AmplifyAuthCognito();
    final api = AmplifyAPI();

    try {
      await Amplify.addPlugins([api, auth]);
      await Amplify.configure(amplifyconfig);
      
      var updatedJWT = await _getIdToken();
      await onTestApi();

      setState(() {
        jwt = updatedJWT;
      });
    } on Exception {}
  }

  Future<String> _getIdToken() async {
    var creds = await Amplify.Auth.fetchAuthSession(options: const CognitoSessionOptions(getAWSCredentials: true)) as CognitoAuthSession;

    var userPoolTokens = creds.userPoolTokens;

    if (userPoolTokens == null) {
      return "";
    }

    return userPoolTokens.idToken.raw;
  }

  Future<void> onTestApi() async {
    var token = await _getIdToken();

    try {
      final restOperation = Amplify.API.get(
        '/tasks',
        headers: {"Authorization": token}
      );

      final response = await restOperation.response;
    } on ApiException catch (e) {
      print('POST call failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
        child: MaterialApp(
        builder: Authenticator.builder(),
        home: Scaffold(
            appBar: AppBar(
            title: const Text('Preeoh JWT'),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: SelectionArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("$jwt"),
                  ],
                ),
              ),
          ),
        ),
    )));
  }
}
