import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocalgroups/Authentication/Database.dart';
import 'package:vocalgroups/Pages/auth/login_page.dart';
import 'package:vocalgroups/Utilis/book.dart';

import '../home_page.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController newName = TextEditingController();
  final TextEditingController newEmail = TextEditingController();

  String? username = '';
  String? email = '';
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    MaterialPageRoute(builder: (context) => HomePage()).dispose();
    super.dispose();
  }

  getUser() {
    DatabaseService().dataCollection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot element) {
        print(element.data());
      });
    });
  }

  updateStatePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onTanslator', false);
  }

  DocumentSnapshot? lastEvent;

  bool updated = false;
  int booksamount = 0;
  getCurrentUserListen() async {
    if (mounted) {
      booksamount = await Book().getBooksAmount();
      if (!mounted) return;
      if (FirebaseAuth.instance.currentUser != null) {
        DatabaseService()
            .dataCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots()
            .listen((event) {
          username = event.get('username');
          email = event.get('email');

          setState(() {});
        });
      }
    }
  }

  Future getCurrentUser() async {
    DocumentSnapshot? userdata;
    if (FirebaseAuth.instance.currentUser != null) {
      DatabaseService()
          .dataCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((event) {});
      username = userdata!.get('username');
      email = userdata.get('email');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    updateStatePage();
    getCurrentUserListen();

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxHeight >= 600) {
        return SingleChildScrollView(
          child: Container(
            margin: MediaQuery.of(context).padding,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 100 * 85,
                          width: MediaQuery.of(context).size.width / 100 * 98,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Material(
                                borderRadius: BorderRadius.circular(12),
                                elevation: 4,
                                child: Container(
                                  height: MediaQuery.of(context).size.height /
                                      100 *
                                      30,
                                  width: MediaQuery.of(context).size.width /
                                      100 *
                                      93.5,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.grey[200],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    style: new TextStyle(
                                                      fontSize: 0.0,
                                                      color: Colors.black,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: 'User: ',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      TextSpan(
                                                        text: '${username!}',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    showUpdateName(context);
                                                  },
                                                  icon: Icon(Icons.edit),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 0,
                                          indent: 2,
                                          endIndent: 2,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.grey[200],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      style: new TextStyle(
                                                        fontSize: 0.0,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: 'Email: ',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        TextSpan(
                                                          text: '${email!}',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      showUpdateEmail(context);
                                                    },
                                                    icon: Icon(Icons.edit),
                                                  )
                                                ],
                                              ),
                                            )),
                                        Divider(
                                          thickness: 0,
                                          indent: 2,
                                          endIndent: 2,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    'Books $booksamount',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    child: VerticalDivider(
                                                      thickness: 1,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Contacts ${0}',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Material(
                                borderRadius: BorderRadius.circular(12),
                                elevation: 4,
                                child: Container(
                                  height: MediaQuery.of(context).size.height /
                                      100 *
                                      35,
                                  width: MediaQuery.of(context).size.width /
                                      100 *
                                      93.5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image:
                                              AssetImage('assets/empty.png')),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  if (mounted) {
                                    FirebaseAuth.instance.signOut();
                                  }

                                  Future.delayed(Duration(milliseconds: 100))
                                      .then((value) => Navigator.of(context)
                                        ..pushReplacement(MaterialPageRoute(
                                            builder: (context) =>
                                                LoginPage())));
                                },
                                icon: Icon(Icons.logout),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return SingleChildScrollView(
          child: Container(
            margin: MediaQuery.of(context).padding,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 100 * 84,
                          width: MediaQuery.of(context).size.width / 100 * 95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Material(
                                borderRadius: BorderRadius.circular(12),
                                elevation: 4,
                                child: Container(
                                  height: MediaQuery.of(context).size.height /
                                      100 *
                                      40,
                                  width: MediaQuery.of(context).size.width /
                                      100 *
                                      93.5,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.grey[200],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(2),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    style: new TextStyle(
                                                      fontSize: 0.0,
                                                      color: Colors.black,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: 'User: ',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      TextSpan(
                                                        text: '${username!}',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    showUpdateName(context);
                                                  },
                                                  icon: Icon(Icons.edit),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 0,
                                          indent: 2,
                                          endIndent: 2,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.grey[200],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(2),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      style: new TextStyle(
                                                        fontSize: 0.0,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: 'Email: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        TextSpan(
                                                          text: '${email!}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      showUpdateEmail(context);
                                                    },
                                                    icon: Icon(Icons.edit),
                                                  )
                                                ],
                                              ),
                                            )),
                                        Divider(
                                          thickness: 0,
                                          indent: 2,
                                          endIndent: 2,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    'Books $booksamount',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    child: VerticalDivider(
                                                      thickness: 0,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Contacts ${0}',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Material(
                                borderRadius: BorderRadius.circular(12),
                                elevation: 4,
                                child: Container(
                                  height: MediaQuery.of(context).size.height /
                                      100 *
                                      25,
                                  width: MediaQuery.of(context).size.width /
                                      100 *
                                      93.5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image:
                                              AssetImage('assets/empty.png')),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  if (mounted) {
                                    FirebaseAuth.instance.signOut();
                                  }

                                  Future.delayed(Duration(milliseconds: 100))
                                      .then((value) => Navigator.of(context)
                                        ..pushReplacement(MaterialPageRoute(
                                            builder: (context) =>
                                                LoginPage())));
                                },
                                icon: Icon(Icons.logout),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  void showUpdateName(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              height: MediaQuery.of(context).size.height / 100 * 25,
              width: MediaQuery.of(context).size.width / 100 * 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Enter a new name'),
                  TextField(
                    controller: newName,
                    onChanged: (value) {},
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical:
                              MediaQuery.of(context).size.height / 100 * 1,
                          horizontal: 10.0),
                      labelText: 'Enter name',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: InkWell(
                          onTap: () {
                            newName.clear();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height / 100 * 6,
                            width: MediaQuery.of(context).size.width / 100 * 12,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Icon(Icons.clear,
                                  size: 20.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: InkWell(
                          onTap: () {
                            DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .updateUserData(newName.text.trim(), email!);
                            newName.clear();

                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height / 100 * 6,
                            width: MediaQuery.of(context).size.width / 100 * 12,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Icon(Icons.check,
                                  size: 20.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void showUpdateEmail(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              height: MediaQuery.of(context).size.height / 100 * 25,
              width: MediaQuery.of(context).size.width / 100 * 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Enter a new email'),
                  TextField(
                    controller: newEmail,
                    onChanged: (value) {},
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical:
                              MediaQuery.of(context).size.height / 100 * 1,
                          horizontal: 10.0),
                      labelText: 'Enter email',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: InkWell(
                          onTap: () {
                            newEmail.clear();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height / 100 * 6,
                            width: MediaQuery.of(context).size.width / 100 * 12,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Icon(Icons.clear,
                                  size: 20.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: InkWell(
                          onTap: () {
                            DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .updateUserData(
                                    username!, newEmail.text.trim());
                            newName.clear();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height / 100 * 6,
                            width: MediaQuery.of(context).size.width / 100 * 12,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Icon(Icons.check,
                                  size: 20.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
