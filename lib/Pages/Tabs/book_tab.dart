import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocalgroups/Authentication/Database.dart';
import 'package:vocalgroups/Utilis/book.dart';

class BookTab extends StatefulWidget {
  @override
  _BookTabState createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> {
  String dropdownValue = "One";
  var selectedbook, selectedType;
  TextEditingController rowOneStringCtrl = TextEditingController();
  TextEditingController rowTwoStringCtrl = TextEditingController();
  List<String> leftContent = [];
  List<String> rightContent = [];
  getContent(AsyncSnapshot snapshot) async {
    leftContent = List.from(snapshot.data!.docs[0].get('leftContent'));
    rightContent = List.from(snapshot.data!.docs[0].get('rightContent'));
  }

  String? currentBookName = 'english';
  String? lastBookName;
  bool removeMode = false;

  getCurrentBook() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentBookName = prefs.getString('currentbook');
    setState(() {});
  }

  updateStatePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onTanslator', false);
  }

  @override
  Widget build(BuildContext context) {
    updateStatePage();
    return Container(
        margin: MediaQuery.of(context).padding,
        child: StreamBuilder(
          stream: DatabaseService()
              .dataCollection
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('books')
              .doc(currentBookName!)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxHeight >= 600) {
                  return Container(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height /
                                      100 *
                                      84,
                                  width: MediaQuery.of(context).size.width /
                                      100 *
                                      95,
                                  decoration: BoxDecoration(
                                      color: Color(0xffdbe2ef),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(12),
                                        elevation: 4,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100 *
                                              92,
                                          decoration: BoxDecoration(
                                            color: Color(0xff3f72af),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(4),
                                            child: Text(
                                              currentBookName!,
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                100 *
                                                66,
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          padding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          itemCount: snapshot.data
                                              .get('leftContent')
                                              .length,
                                          itemBuilder: (context, index) {
                                            String leftContent = snapshot.data!
                                                .get('leftContent')[index];
                                            String rightContent = snapshot.data!
                                                .get('rightContent')[index];
                                            return Padding(
                                              padding: EdgeInsets.all(4),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5, right: 5),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          leftContent,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          rightContent,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      if (removeMode)
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 5),
                                                            child: Container(
                                                              height: 30,
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  Book().removeBookRow(
                                                                      currentBookName!,
                                                                      index);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                color: Colors
                                                                    .redAccent,
                                                                icon: Icon(Icons
                                                                    .delete),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if (!removeMode)
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                            height: 30,
                                                            child:
                                                                VerticalDivider(
                                                              thickness: 2,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                100 *
                                                3.5,
                                        right:
                                            MediaQuery.of(context).size.width /
                                                100 *
                                                3.5,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                100 *
                                                28,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Color(0xff3f72af),
                                            ),
                                            child: IconButton(
                                              iconSize: 25,
                                              onPressed: () {
                                                print(removeMode);
                                                if (removeMode) {
                                                  removeMode = false;
                                                } else {
                                                  removeMode = true;
                                                }
                                                if (mounted) setState(() {});
                                              },
                                              icon: Icon(Icons.remove),
                                            ),
                                          ),
                                          StreamBuilder<QuerySnapshot>(
                                            stream: DatabaseService()
                                                .dataCollection
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .collection('books')
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot snapshot) {
                                              if (!snapshot.hasData)
                                                return CircularProgressIndicator();
                                              else {
                                                List<DropdownMenuItem>
                                                    bookItems = [];
                                                for (int i = 0;
                                                    i <
                                                        snapshot
                                                            .data!.docs.length;
                                                    i++) {
                                                  DocumentSnapshot snap =
                                                      snapshot.data!.docs[i];
                                                  bookItems.add(
                                                    DropdownMenuItem(
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            100 *
                                                            25,
                                                        child: Text(
                                                          snap.id,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      value: "${snap.id}",
                                                    ),
                                                  );
                                                }
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(Icons.bookmarks,
                                                        size: 20.0,
                                                        color:
                                                            Color(0xff112d4e)),
                                                    DropdownButton<dynamic>(
                                                      isExpanded: false,
                                                      items: bookItems,
                                                      onChanged: (bookValue) {
                                                        setState(() {
                                                          currentBookName =
                                                              bookValue;
                                                        });
                                                      },
                                                      value: currentBookName,
                                                      elevation: 5,
                                                      hint: new Text(
                                                        "Choose Book",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff112d4e)),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                            },
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                100 *
                                                28,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Color(0xff3f72af),
                                            ),
                                            child: IconButton(
                                              iconSize: 25,
                                              onPressed: () {
                                                removeMode = false;
                                                if (mounted) setState(() {});
                                                showAddRow(context);
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height /
                                      100 *
                                      84,
                                  width: MediaQuery.of(context).size.width /
                                      100 *
                                      95,
                                  decoration: BoxDecoration(
                                      color: Color(0xffdbe2ef),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(12),
                                        elevation: 4,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100 *
                                              92,
                                          decoration: BoxDecoration(
                                            color: Color(0xff3f72af),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(4),
                                            child: Text(
                                              currentBookName!,
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                100 *
                                                60,
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          padding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          itemCount: snapshot.data
                                              .get('leftContent')
                                              .length,
                                          itemBuilder: (context, index) {
                                            String leftContent = snapshot.data!
                                                .get('leftContent')[index];
                                            String rightContent = snapshot.data!
                                                .get('rightContent')[index];
                                            return Padding(
                                              padding: EdgeInsets.all(4),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5, right: 5),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          leftContent,
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          rightContent,
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      if (removeMode)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 8,
                                                            bottom: 2,
                                                          ),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Container(
                                                              height: 30,
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  Book().removeBookRow(
                                                                      currentBookName!,
                                                                      index);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                color: Colors
                                                                    .redAccent,
                                                                icon: Icon(Icons
                                                                    .delete),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if (!removeMode)
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                            height: 22,
                                                            child:
                                                                VerticalDivider(
                                                              thickness: 2,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                100 *
                                                1.4,
                                        left:
                                            MediaQuery.of(context).size.width /
                                                100 *
                                                3.5,
                                        right:
                                            MediaQuery.of(context).size.width /
                                                100 *
                                                3.5,
                                      ),
                                      child: Container(
                                        height: 40,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  100 *
                                                  25,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Color(0xff3f72af),
                                              ),
                                              child: IconButton(
                                                iconSize: 25,
                                                onPressed: () {
                                                  print(removeMode);
                                                  if (removeMode) {
                                                    removeMode = false;
                                                  } else {
                                                    removeMode = true;
                                                  }
                                                  if (mounted) setState(() {});
                                                },
                                                icon: Icon(Icons.remove),
                                              ),
                                            ),
                                            StreamBuilder<QuerySnapshot>(
                                              stream: DatabaseService()
                                                  .dataCollection
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection('books')
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot snapshot) {
                                                if (!snapshot.hasData)
                                                  return CircularProgressIndicator();
                                                else {
                                                  List<DropdownMenuItem>
                                                      bookItems = [];
                                                  for (int i = 0;
                                                      i <
                                                          snapshot.data!.docs
                                                              .length;
                                                      i++) {
                                                    DocumentSnapshot snap =
                                                        snapshot.data!.docs[i];
                                                    bookItems.add(
                                                      DropdownMenuItem(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              100 *
                                                              25,
                                                          child: Text(
                                                            snap.id,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        value: "${snap.id}",
                                                      ),
                                                    );
                                                  }
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(Icons.bookmarks,
                                                          size: 15.0,
                                                          color: Color(
                                                              0xff112d4e)),
                                                      DropdownButton<dynamic>(
                                                        isExpanded: false,
                                                        items: bookItems,
                                                        onChanged: (bookValue) {
                                                          setState(() {
                                                            currentBookName =
                                                                bookValue;
                                                          });
                                                        },
                                                        value: currentBookName,
                                                        elevation: 5,
                                                        underline: null,
                                                        hint: new Text(
                                                          "Choose Book",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff112d4e)),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              },
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  100 *
                                                  25,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Color(0xff3f72af),
                                              ),
                                              child: IconButton(
                                                iconSize: 25,
                                                onPressed: () {
                                                  removeMode = false;
                                                  if (mounted) setState(() {});
                                                  showAddRowSmallScreen(
                                                      context);
                                                },
                                                icon: Icon(Icons.add),
                                              ),
                                            ),
                                          ],
                                        ),
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
                  );
                }
              });
            }
          },
        ));
  }

  void showAddRow(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              height: MediaQuery.of(context).size.height / 100 * 22,
              width: MediaQuery.of(context).size.width / 100 * 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add row to current book",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text("Left row"),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width / 100 * 40,
                              child: TextField(
                                controller: rowOneStringCtrl,
                                onChanged: (value) {},
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              0,
                                      horizontal: 10.0),
                                  labelText: 'Left',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  fillColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text("Right row"),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width / 100 * 40,
                              child: TextField(
                                controller: rowTwoStringCtrl,
                                onChanged: (value) {},
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              0,
                                      horizontal: 10.0),
                                  labelText: 'Right',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  fillColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.close),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Book().addBookRow(
                                  currentBookName!,
                                  rowOneStringCtrl.text.trim(),
                                  rowTwoStringCtrl.text.trim());
                              rowOneStringCtrl.clear();
                              rowTwoStringCtrl.clear();
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showAddRowSmallScreen(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              height: MediaQuery.of(context).size.height / 100 * 33.5,
              width: MediaQuery.of(context).size.width / 100 * 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add row to current book",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Left row",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width / 100 * 38,
                              child: TextField(
                                controller: rowOneStringCtrl,
                                onChanged: (value) {},
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              0,
                                      horizontal: 10.0),
                                  labelText: 'Left',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  fillColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Right row",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width / 100 * 38,
                              child: TextField(
                                controller: rowTwoStringCtrl,
                                onChanged: (value) {},
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              0,
                                      horizontal: 10.0),
                                  labelText: 'Right',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  fillColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.close),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Book().addBookRow(
                                  currentBookName!,
                                  rowOneStringCtrl.text.trim(),
                                  rowTwoStringCtrl.text.trim());
                              rowOneStringCtrl.clear();
                              rowTwoStringCtrl.clear();
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
