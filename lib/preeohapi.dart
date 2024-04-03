import 'dart:io';

import 'data.dart';
import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:http/http.dart' as http;

Future<String> fetchIdToken() async {
  try {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    final result = await cognitoPlugin.fetchAuthSession();
    final idToken = result.userPoolTokensResult.value.idToken.toJson();

    return idToken;
  } on AuthException catch (e) {
    safePrint('Error retrieving auth session: ${e.message}');
    return "";
  }
}

Future<List<Task>> getTasks() async {
  var token = await fetchIdToken();

  final response = await http.get(
      Uri.parse('https://preeoh-api-34d248de0ab6.herokuapp.com/tasks'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      });

  if (response.statusCode == 200) {
    return _parseTasks(response.body);
  } else {
    return [];
  }
}

List<Task> _parseTasks(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Task>((json) => Task.fromJson(json)).toList();
}
