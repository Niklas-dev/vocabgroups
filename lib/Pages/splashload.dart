import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width / 100 * 100,
        child: GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails details) {
            if (details.primaryDelta! <= 1) {
              pushHomePage();
            }
          },
          child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 100 * 15,
                    width: MediaQuery.of(context).size.width / 100 * 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/logo/logo_large.png'),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          "Swipe Up",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  pushHomePage() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }
}
