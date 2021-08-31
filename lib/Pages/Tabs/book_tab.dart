import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:vocalgroups/Authentication/Database.dart';
import 'package:vocalgroups/Utilis/book.dart';

class BookTab extends StatefulWidget {
  @override
  _BookTabState createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> {
  final translator = GoogleTranslator();
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

  String? currentBookName = "Empty";
  String? lastBookName;
  bool removeMode = false;

  final List<String> allLanguages = [
    'English',
    'German',
    'Italian',
    'French',
  ];
  final List<String> languageCodes = [
    'en',
    'de',
    'it',
    'fr',
  ];

  String firstLanguage = "English";

  int firstIndex = 0;
  int secondIndex = 0;

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
        padding: MediaQuery.of(context).padding,
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxHeight >= 600) {
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 100 * 95,
                            height:
                                MediaQuery.of(context).size.height / 100 * 7,
                            decoration: BoxDecoration(
                              color: const Color(0xff3F72AF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  currentBookName!,
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
                        if (currentBookName != "Empty")
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 14.0, right: 14.0),
                            child: StreamBuilder<Object>(
                                stream: DatabaseService()
                                    .dataCollection
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('books')
                                    .doc(currentBookName!)
                                    .snapshots(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    String leftRowName =
                                        snapshot.data!.get('leftColumnName');
                                    String rightRowName =
                                        snapshot.data!.get('rightColumnName');
                                    return Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              leftRowName,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              rightRowName,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                          ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (currentBookName != "Empty") {
                              return StreamBuilder(
                                  stream: DatabaseService()
                                      .dataCollection
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection('books')
                                      .doc(currentBookName!)
                                      .snapshots(),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text("");
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              100 *
                                              66,
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0),
                                            itemCount: snapshot.data
                                                .get('leftContent')
                                                .length,
                                            itemBuilder: (context, index) {
                                              if (currentBookName == "Empty") {
                                                return Container();
                                              } else {
                                                String leftContent = snapshot
                                                    .data!
                                                    .get('leftContent')[index];
                                                String rightContent = snapshot
                                                    .data!
                                                    .get('rightContent')[index];
                                                return Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
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
                                                                  Alignment
                                                                      .center,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            5),
                                                                child:
                                                                    Container(
                                                                  height: 30,
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
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
                                                                  Alignment
                                                                      .center,
                                                              child: Container(
                                                                height: 30,
                                                                child:
                                                                    VerticalDivider(
                                                                  thickness: 2,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                  });
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height /
                                      100 *
                                      66,
                                  child: Padding(
                                    padding: const EdgeInsets.all(40.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            image: AssetImage(
                                                'assets/notfound.png')),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (currentBookName != "Empty")
                              Container(
                                width: MediaQuery.of(context).size.width /
                                    100 *
                                    26,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xff3F72AF),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffdbe2ef),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: DatabaseService()
                                        .dataCollection
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection('books')
                                        .snapshots(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (!snapshot.hasData)
                                        return CircularProgressIndicator();
                                      else {
                                        List<DropdownMenuItem> bookItems = [];
                                        bookItems.add(
                                          DropdownMenuItem(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  100 *
                                                  25,
                                              child: Text(
                                                "Empty",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            value: "Empty",
                                          ),
                                        );
                                        for (int i = 0;
                                            i < snapshot.data!.docs.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data!.docs[i];
                                          bookItems.add(
                                            DropdownMenuItem(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    100 *
                                                    25,
                                                child: Text(
                                                  snap.id,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
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
                                                color: Color(0xff112d4e)),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton<dynamic>(
                                                isExpanded: false,
                                                dropdownColor:
                                                    Color(0xffdbe2ef),
                                                items: bookItems,
                                                onChanged: (bookValue) {
                                                  setState(() {
                                                    currentBookName = bookValue;
                                                  });
                                                },
                                                value: currentBookName,
                                                elevation: 8,
                                                hint: new Text(
                                                  "Choose Book",
                                                  style: TextStyle(
                                                      color: Color(0xff112d4e)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            if (currentBookName != "Empty")
                              Container(
                                width: MediaQuery.of(context).size.width /
                                    100 *
                                    26,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xff3F72AF),
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
                      ],
                    ),
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
                            height:
                                MediaQuery.of(context).size.height / 100 * 84,
                            width: MediaQuery.of(context).size.width / 100 * 95,
                            decoration: BoxDecoration(
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
                                    width: MediaQuery.of(context).size.width /
                                        100 *
                                        92,
                                    decoration: BoxDecoration(
                                      color: Color(0xff3f72af),
                                      borderRadius: BorderRadius.circular(12),
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
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  if (currentBookName != "Empty") {
                                    return StreamBuilder(
                                        stream: DatabaseService()
                                            .dataCollection
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection('books')
                                            .doc(currentBookName!)
                                            .snapshots(),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (!snapshot.hasData) {
                                            return Text("");
                                          } else {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    100 *
                                                    65,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0),
                                                  itemCount: snapshot.data
                                                      .get('leftContent')
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (currentBookName ==
                                                        "Empty") {
                                                      return Container();
                                                    } else {
                                                      String leftContent =
                                                          snapshot.data!.get(
                                                                  'leftContent')[
                                                              index];
                                                      String rightContent =
                                                          snapshot.data!.get(
                                                                  'rightContent')[
                                                              index];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[200],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5,
                                                                    right: 5),
                                                            child: Stack(
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                    leftContent,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: Text(
                                                                    rightContent,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                ),
                                                                if (removeMode)
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              5),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            30,
                                                                        child:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            Book().removeBookRow(currentBookName!,
                                                                                index);
                                                                            setState(() {});
                                                                          },
                                                                          color:
                                                                              Colors.redAccent,
                                                                          icon:
                                                                              Icon(Icons.delete),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if (!removeMode)
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          VerticalDivider(
                                                                        thickness:
                                                                            2,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                100 *
                                                65,
                                        child: Padding(
                                          padding: const EdgeInsets.all(40.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fitWidth,
                                                  image: AssetImage(
                                                      'assets/notfound.png')),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height /
                                      100 *
                                      1.5,
                                  left: MediaQuery.of(context).size.width /
                                      100 *
                                      3.5,
                                  right: MediaQuery.of(context).size.width /
                                      100 *
                                      3.5,
                                ),
                                child: Container(
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (currentBookName != "Empty")
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100 *
                                              22,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: const Color(0xff3F72AF),
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
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffdbe2ef),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: StreamBuilder<QuerySnapshot>(
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
                                                          "Empty",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      value: "Empty",
                                                    ),
                                                  );
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
                                                      DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                            dynamic>(
                                                          isExpanded: false,
                                                          dropdownColor:
                                                              Color(0xffdbe2ef),
                                                          items: bookItems,
                                                          onChanged:
                                                              (bookValue) {
                                                            setState(() {
                                                              currentBookName =
                                                                  bookValue;
                                                            });
                                                          },
                                                          value:
                                                              currentBookName,
                                                          elevation: 5,
                                                          underline: null,
                                                          hint: new Text(
                                                            "Choose Book",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff112d4e)),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (currentBookName != "Empty")
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100 *
                                              22,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: const Color(0xff3F72AF),
                                          ),
                                          child: IconButton(
                                            iconSize: 25,
                                            onPressed: () {
                                              removeMode = false;
                                              if (mounted) setState(() {});
                                              showAddRowSmallScreen(context);
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
        }));
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
              height: MediaQuery.of(context).size.height / 100 * 33,
              width: MediaQuery.of(context).size.width / 100 * 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add",
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
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.translate),
                                    onPressed: () async {
                                      Translation translation =
                                          await translator.translate(
                                              rowOneStringCtrl.text.trim(),
                                              to: languageCodes[firstIndex]);

                                      rowTwoStringCtrl.text = translation.text;
                                      setState(() {});
                                    },
                                  ),
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
                  StatefulBuilder(builder: (context, setState) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            rowOneStringCtrl.text = "";
                            rowTwoStringCtrl.text = "";
                          },
                          child: Text(
                            "Clear All",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: Container(
                                child: Text("to"),
                              ),
                            ),
                            DropdownButton(
                              value: firstLanguage,
                              iconSize: 20,
                              elevation: 1,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              underline: Container(
                                height: 1,
                                color: Color(0xff112d4e),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  firstLanguage = newValue!;
                                  firstIndex = allLanguages.indexOf(newValue);
                                });
                              },
                              items: allLanguages.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(value),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
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
                            color: Colors.blueAccent,
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
                            color: Colors.grey[200],
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
                            color: Colors.blueAccent,
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
