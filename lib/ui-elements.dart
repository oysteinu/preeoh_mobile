import 'package:flutter/material.dart';
import 'package:preeoh_mobile/preeohapi.dart';

import 'data.dart';

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
