import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'Tabs/book_tab.dart';
import 'Tabs/books_tab.dart';
import 'Tabs/groups_tab.dart';
import 'Tabs/home_tab.dart';
import 'Tabs/translator_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  int currentIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    BooksTab(),
    BookTab(),
    GroupsTab(),
    TranslatorTab(),
  ];

  selectTab(int index) {
    return tabs[index];
  }

  void inputData() async {
    final User user = await auth.currentUser!;
    final uid = user.uid;
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    inputData();

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 2.5),
        child: GNav(
          rippleColor: Colors.blueGrey, // tab button ripple color when pressed
          hoverColor: Colors.grey, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 15, // tab button border
          // tab button border // tab button shadow
          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 300), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Color(0xff112d4e), // unselected icon color
          activeColor: Color(0xff3f72af), // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor:
              Colors.purple.withOpacity(0.1), // selected tab background color
          padding: EdgeInsets.symmetric(
              horizontal: 15, vertical: 10), // navigation bar padding
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.bookmark,
              text: 'Books',
            ),
            GButton(
              icon: FontAwesomeIcons.book,
              text: 'Book',
            ),
            GButton(
              icon: Icons.group,
              text: 'Groups',
            ),
            GButton(
              icon: Icons.g_translate,
              text: 'Translator',
            )
          ],

          onTabChange: (index) {
            currentIndex = index;
            setState(() {});
            debugPrint("$index");
          },
        ),
      ),
      body: selectTab(currentIndex),
    );
  }
}
