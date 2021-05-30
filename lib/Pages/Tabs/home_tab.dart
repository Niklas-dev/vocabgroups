import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vocalgroups/Authentication/Database.dart';
import 'package:vocalgroups/Authentication/authentication.dart';
import 'package:vocalgroups/Pages/auth/login_page.dart';
import 'package:vocalgroups/Utilis/book.dart';

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

  getUser() {
    DatabaseService().dataCollection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot element) {
        print(element.data());
      });
    });
  }

  getCurrentUser() async {
    final userRef = DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid);

    DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      if (mounted) {
        setState(() {
          username = event.get('username');
          email = event.get('email');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    //print(username);
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
                          color: Color(0xff3f72af),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            elevation: 5,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height / 100 * 25,
                              width: MediaQuery.of(context).size.width /
                                  100 *
                                  93.5,
                              decoration: BoxDecoration(
                                  color: Color(0xfff9f7f7),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 8, bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
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
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              TextSpan(
                                                text: '${username!}',
                                                style: TextStyle(
                                                    fontSize: 18,
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
                                    Divider(
                                      thickness: 1,
                                      indent: 2,
                                      endIndent: 2,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: new TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Email: ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              TextSpan(
                                                text: '${email!}',
                                                style: TextStyle(
                                                    fontSize: 18,
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
                                    Divider(
                                      thickness: 1,
                                      indent: 2,
                                      endIndent: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Books ${0}',
                                          style: TextStyle(fontSize: 20),
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
                                          style: TextStyle(fontSize: 20),
                                        )
                                      ],
                                    )
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
                            elevation: 5,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height / 100 * 25,
                              width: MediaQuery.of(context).size.width /
                                  100 *
                                  93.5,
                              decoration: BoxDecoration(
                                  color: Color(0xfff9f7f7),
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
                        Container(
                          child: IconButton(
                            onPressed: () async {
                              AuthenticationService().signOut();
                              Future.delayed(Duration(milliseconds: 300))
                                  .then((value) => Navigator.of(context).pop());
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

  void showUpdateName(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              height: MediaQuery.of(context).size.height / 100 * 20,
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
                                MediaQuery.of(context).size.height / 100 * 5,
                            width: MediaQuery.of(context).size.width / 100 * 10,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Icon(Icons.clear,
                                  size: 18.0, color: Colors.black),
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
                                MediaQuery.of(context).size.height / 100 * 5,
                            width: MediaQuery.of(context).size.width / 100 * 10,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Icon(Icons.check,
                                  size: 18.0, color: Colors.black),
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
              height: MediaQuery.of(context).size.height / 100 * 20,
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
                                MediaQuery.of(context).size.height / 100 * 5,
                            width: MediaQuery.of(context).size.width / 100 * 10,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Icon(Icons.clear,
                                  size: 18.0, color: Colors.black),
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
                                MediaQuery.of(context).size.height / 100 * 5,
                            width: MediaQuery.of(context).size.width / 100 * 10,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Icon(Icons.check,
                                  size: 18.0, color: Colors.black),
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
