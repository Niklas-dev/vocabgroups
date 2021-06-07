import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocalgroups/Utilis/keyboard_check.dart';
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

  @override
  void initState() {
    super.initState();
  }

  bool? onTranslatorBool = true;
  Future<bool> onTranslatorPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    onTranslatorBool = true;
    onTranslatorBool = prefs.getBool('onTanslator');
    setState(() {});
    return onTranslatorBool!;
  }

  void inputData() {}

  @override
  Widget build(BuildContext context) {
    onTranslatorPage();
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: onTranslatorBool,
        floatingActionButton: KeyboardVisibilityBuilder(
          builder: (context, child, isKeyboardVisible) {
            if (isKeyboardVisible && mounted) {
              return Container(
                height: 60,
                width: 60,
                child: FloatingActionButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Icon(Icons.arrow_downward),
                ),
              );
            } else {
              return Container(
                child: Text(''),
              );
            }
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 2.5),
          child: GNav(
            rippleColor:
                Colors.blueGrey, // tab button ripple color when pressed
            hoverColor: Colors.grey, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15, // tab button border
            // tab button border // tab button shadow
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 300), // tab animation duration
            gap: 4, // the tab button gap between icon and text
            color: Color(0xff112d4e), // unselected icon color
            activeColor: Color(0xff3f72af), // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor:
                Colors.purple.withOpacity(0.1), // selected tab background color
            padding: EdgeInsets.symmetric(
                horizontal: 10, vertical: 10), // navigation bar padding
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
      ),
    );
  }
}

class UserData {
  String? username = '';
  String? email = '';

  UserData({
    this.username,
    this.email,
  });
}
