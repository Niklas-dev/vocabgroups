import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocalgroups/Authentication/Database.dart';
import 'package:vocalgroups/Utilis/book.dart';

class BooksTab extends StatefulWidget {
  @override
  _BooksTabState createState() => _BooksTabState();
}

class _BooksTabState extends State<BooksTab> {
  Random random = new Random();
  bool public = false;
  TextEditingController booknameCtrl = TextEditingController();
  TextEditingController leftnameCtrl = TextEditingController();
  TextEditingController rightnameCtrl = TextEditingController();
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
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxHeight >= 600) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Container(
                                width: MediaQuery.of(context).size.width /
                                    100 *
                                    95,
                                height: MediaQuery.of(context).size.height /
                                    100 *
                                    7,
                                decoration: BoxDecoration(
                                  color: const Color(0xff3F72AF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Text(
                                      'Books',
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
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height /
                                    100 *
                                    20,
                                width: MediaQuery.of(context).size.width /
                                    100 *
                                    94.6,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  itemCount: snapshot.data.docs.length + 1,
                                  itemBuilder: (context, index) {
                                    final list = snapshot.data.docs;
                                    if (index == 0) {
                                      return Padding(
                                        padding: EdgeInsets.all(8),
                                        child: InkWell(
                                          onTap: () {
                                            showAddBook(context);
                                          },
                                          child: Material(
                                            elevation: 5,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              height: 15,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  100 *
                                                  30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Color(0xfff9f7f7),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.add),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Padding(
                                      padding: EdgeInsets.all(8),
                                      child: InkWell(
                                        onTap: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setString('currentbook',
                                              list[index - 1]['bookname']);
                                        },
                                        child: Material(
                                          elevation: 5,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Container(
                                            height: 15,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                100 *
                                                30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Color(0xfff9f7f7),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2,
                                                          right: 2,
                                                          top: 40),
                                                  child: Wrap(
                                                    children: [
                                                      Text(
                                                        list[index - 1]
                                                            ['bookname'],
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      100 *
                                                      5,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff3f72af),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                      bottomRight:
                                                          Radius.circular(12),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Book().deleteBook(
                                                                list[index - 1][
                                                                    'bookname']);
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            size: 22,
                                                            color: Color(
                                                                0xff112d4e),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        child: InkWell(
                                                          onTap: () {},
                                                          child: Icon(
                                                            Icons.edit,
                                                            size: 22,
                                                            color: Color(
                                                                0xff112d4e),
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
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 100.0,
                          ),
                          child: Container(
                            height: 300,
                            width: 400,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/book_lover.png')),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width / 100 * 95,
                              height:
                                  MediaQuery.of(context).size.height / 100 * 8,
                              decoration: BoxDecoration(
                                color: const Color(0xff3F72AF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Text(
                                    'Books',
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
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height /
                                      100 *
                                      22,
                                  width: MediaQuery.of(context).size.width /
                                      100 *
                                      94.6,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    itemCount: snapshot.data.docs.length + 1,
                                    itemBuilder: (context, index) {
                                      final list = snapshot.data.docs;
                                      if (index == 0) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: InkWell(
                                            onTap: () {
                                              showAddBookSmall(context);
                                            },
                                            child: Material(
                                              elevation: 5,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    100 *
                                                    50,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    100 *
                                                    28,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Color(0xfff9f7f7),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.add),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return Padding(
                                        padding:
                                            EdgeInsets.only(left: 4, right: 4),
                                        child: InkWell(
                                          onTap: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setString('currentbook',
                                                list[index - 1]['bookname']);
                                          },
                                          child: Material(
                                            elevation: 5,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  100 *
                                                  50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  100 *
                                                  28,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Color(0xfff9f7f7),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2,
                                                            right: 2,
                                                            top: 24),
                                                    child: Wrap(
                                                      children: [
                                                        Text(
                                                          list[index - 1]
                                                              ['bookname'],
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            100 *
                                                            5,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff3f72af),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(12),
                                                        bottomRight:
                                                            Radius.circular(12),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Book().deleteBook(
                                                                  list[index -
                                                                          1][
                                                                      'bookname']);
                                                            },
                                                            child: Icon(
                                                              Icons.delete,
                                                              size: 18,
                                                              color: Color(
                                                                  0xff112d4e),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          child: InkWell(
                                                            onTap: () {},
                                                            child: Icon(
                                                              Icons.edit,
                                                              size: 18,
                                                              color: Color(
                                                                  0xff112d4e),
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
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        100 *
                                        45,
                                    width: MediaQuery.of(context).size.height /
                                        100 *
                                        50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/book_lover.png')),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  void showAddBook(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Container(
            height: MediaQuery.of(context).size.height / 100 * 40,
            width: MediaQuery.of(context).size.width / 100 * 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create book",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: booknameCtrl,
                    onChanged: (value) {},
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical:
                              MediaQuery.of(context).size.height / 100 * 0,
                          horizontal: 10.0),
                      labelText: 'Bookname',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              "Left row name",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 100 * 38,
                            child: TextField(
                              controller: leftnameCtrl,
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
                              "Right row name",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 100 * 38,
                            child: TextField(
                              controller: rightnameCtrl,
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
                StatefulBuilder(
                  builder: (context, setState) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: public,
                          onChanged: (newValue) {
                            setState(() {
                              public = newValue!;
                            });
                          },
                        ),
                        Text("Public book")
                      ],
                    );
                  },
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12)),
                          height: MediaQuery.of(context).size.height / 100 * 6,
                          width: MediaQuery.of(context).size.width / 100 * 30,
                          child: Center(
                              child: Text(
                            "Close",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: InkWell(
                        onTap: () async {
                          if (booknameCtrl.text.trim().length <= 20) {
                            int index = await createBookIndex();
                            Book().addBook(
                                booknameCtrl.text.trim(), public, index);
                            Navigator.of(context).pop();
                          } else {
                            print("Too long");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(12)),
                          height: MediaQuery.of(context).size.height / 100 * 6,
                          width: MediaQuery.of(context).size.width / 100 * 30,
                          child: Center(
                              child: Text(
                            "Create",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showAddBookSmall(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 100 * 55,
              width: MediaQuery.of(context).size.width / 100 * 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create book",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: booknameCtrl,
                      onChanged: (value) {},
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height / 100 * 0,
                            horizontal: 10.0),
                        labelText: 'Bookname',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Left row name",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width / 100 * 38,
                              child: TextField(
                                controller: leftnameCtrl,
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
                                "Right row name",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width / 100 * 38,
                              child: TextField(
                                controller: rightnameCtrl,
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
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: public,
                            onChanged: (newValue) {
                              setState(() {
                                public = newValue!;
                              });
                            },
                          ),
                          Text("Public book")
                        ],
                      );
                    },
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8)),
                            height:
                                MediaQuery.of(context).size.height / 100 * 6,
                            width: MediaQuery.of(context).size.width / 100 * 30,
                            child: Center(
                                child: Text(
                              "Close",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: InkWell(
                          onTap: () async {
                            int index = await createBookIndex();
                            Book().addBook(
                                booknameCtrl.text.trim(), public, index);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8)),
                            height:
                                MediaQuery.of(context).size.height / 100 * 6,
                            width: MediaQuery.of(context).size.width / 100 * 30,
                            child: Center(
                                child: Text(
                              "Create",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<int> createBookIndex() async {
    int setIndex = 0;
    int currentAmount = await Book().getBooksAmount();
    setIndex = currentAmount;
    return setIndex;
  }
}
