import 'package:flutter/material.dart';
import 'package:vocalgroups/Pages/auth/login_page.dart';

import '../../authentication.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: MediaQuery.of(context).padding,
        color: Colors.red,
        child: Center(
          child: Container(
            child: IconButton(
              onPressed: () {
                AuthenticationService().signOut();

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout),
            ),
          ),
        ));
  }
}
