import 'package:flutter/material.dart';

import 'Pages/auth/login_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VocalGroups',
      theme: ThemeData(),
      home: LoginPage(),
    );
  }
}
