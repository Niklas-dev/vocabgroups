import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocalgroups/Authentication/Database.dart';
import 'package:vocalgroups/Authentication/authentication.dart';
import 'package:vocalgroups/Pages/auth/login_page.dart';

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
    MaterialPageRoute(builder: (context) => HomeTab()).dispose();
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

  @override
  Widget build(BuildContext context) {
    updateStatePage();

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxHeight >= 600) {
        print(constraints.maxHeight);
        return SingleChildScrollView(
          child: Container(
            margin: MediaQuery.of(context).padding,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 100 * 95,
                      height: MediaQuery.of(context).size.height / 100 * 7,
                      decoration: BoxDecoration(
                        color: const Color(0xff3F72AF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            'Dashboard',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            elevation: 4,
                            child: StreamBuilder<Object>(
                                stream: DatabaseService()
                                    .dataCollection
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .snapshots(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    username = snapshot.data["username"];
                                    email = snapshot.data["email"];
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              20,
                                      width: MediaQuery.of(context).size.width /
                                          100 *
                                          93.5,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 8,
                                            bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.grey[50],
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
                                                            text:
                                                                '${username!}',
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
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.grey[50],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(3),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                          showUpdateEmail(
                                                              context);
                                                        },
                                                        icon: Icon(Icons.edit),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(12),
                      elevation: 4,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 100 * 35,
                        width: MediaQuery.of(context).size.width / 100 * 93.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage('assets/empty.png')),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 8, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width / 100 * 94,
                        height: MediaQuery.of(context).size.height / 100 * 9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      child: IconButton(
                                        onPressed: () {
                                          if (mounted) {
                                            FirebaseAuth.instance.signOut();
                                            Future.delayed(
                                                Duration(milliseconds: 100),
                                                () => Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LoginPage())));
                                          }
                                        },
                                        icon: Icon(Icons.logout),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        onPressed: () {
                                          if (mounted) {
                                            AuthenticationService().deleteUser(
                                                "niklas@gmail.com", "123456");
                                            Future.delayed(
                                                Duration(milliseconds: 100),
                                                () => Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                LoginPage())));
                                          }
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
        );
      } else {
        return SingleChildScrollView(
          child: Container(
            margin: MediaQuery.of(context).padding,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 100 * 95,
                      height: MediaQuery.of(context).size.height / 100 * 8,
                      decoration: BoxDecoration(
                        color: const Color(0xff3F72AF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            'Dashboard',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            elevation: 4,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height / 100 * 40,
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
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey[200],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                            FontWeight.w400),
                                                  ),
                                                  TextSpan(
                                                    text: '${username!}',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w300),
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
                                                MainAxisAlignment.spaceBetween,
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
                                                              FontWeight.w400),
                                                    ),
                                                    TextSpan(
                                                      text: '${email!}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w300),
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'Books $booksamount',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Container(
                                                height: 30,
                                                child: VerticalDivider(
                                                  thickness: 0,
                                                ),
                                              ),
                                              Text(
                                                'Contacts ${0}',
                                                style: TextStyle(fontSize: 20),
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
                              height:
                                  MediaQuery.of(context).size.height / 100 * 25,
                              width: MediaQuery.of(context).size.width /
                                  100 *
                                  93.5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: AssetImage('assets/empty.png')),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 8, bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              width:
                                  MediaQuery.of(context).size.width / 100 * 94,
                              height:
                                  MediaQuery.of(context).size.height / 100 * 9,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: IconButton(
                                              onPressed: () {
                                                if (mounted) {
                                                  FirebaseAuth.instance
                                                      .signOut();
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoginPage()));
                                                }
                                              },
                                              icon: Icon(Icons.logout),
                                            ),
                                          ),
                                          Container(
                                            child: IconButton(
                                              onPressed: () {
                                                if (mounted) {
                                                  AuthenticationService()
                                                      .deleteUser(
                                                          "niklas@gmail.com",
                                                          "123456");
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoginPage()));
                                                }
                                              },
                                              icon: Icon(Icons.delete),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
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
                  Text(
                    "Enter new Name",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
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
                  Text(
                    "Enter new Email",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
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
