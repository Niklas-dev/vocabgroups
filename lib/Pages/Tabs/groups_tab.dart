import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:vocalgroups/Authentication/Database.dart';

class GroupsTab extends StatefulWidget {
  @override
  _GroupsTabState createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab> {
  TextEditingController groupNameCtrl = TextEditingController();
  TextEditingController groupIDCtrl = TextEditingController();

  String? currentGroupID = "EozOyVtmPPbBh2QoOOEr";
  String? currentGroupName = "";

  bool createButtonOnClicked = false;

  List groups = [];

  String currentBookName = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: MediaQuery.of(context).padding,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      'Groups',
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
            Text("Click on group to Select"),
            Padding(
              padding: EdgeInsets.only(top: 6),
              child: Container(
                height: MediaQuery.of(context).size.height / 100 * 12.5,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: DatabaseService()
                      .dataCollection
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.get('groupID').length + 1,
                          itemBuilder: (context, index) {
                            final groupdata = snapshot.data;
                            if (snapshot.data.get('groupID').length == 0) {
                              return Text("Please create a group");
                            } else {
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Material(
                                    shadowColor: Colors.blue,
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                showCreateGroup(context),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.blueGrey[50],
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  100 *
                                                  8,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  100 *
                                                  11,
                                              child: Icon(
                                                Icons.group_add,
                                                color: Color(0xff112d4e),
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                          VerticalDivider(
                                            indent: 10,
                                            endIndent: 10,
                                            thickness: 2,
                                          ),
                                          GestureDetector(
                                            onTap: () => showJoinGroup(context),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.blueGrey[50],
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  100 *
                                                  8,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  100 *
                                                  11,
                                              child: Icon(
                                                Icons.groups,
                                                color: Color(0xff112d4e),
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return StreamBuilder(
                                  stream: DatabaseService()
                                      .groupCollection
                                      .doc(groupdata['groupID'][index - 1])
                                      .snapshots(),
                                  builder:
                                      (context, AsyncSnapshot groupsnapshot) {
                                    if (groupsnapshot.connectionState ==
                                        ConnectionState.active) {
                                      String groupname =
                                          groupsnapshot.data.get('name');
                                      return Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            debugPrint("Tapped");
                                            currentGroupID =
                                                groupdata['groupID'][index - 1];
                                            print(currentGroupID);
                                            currentGroupName =
                                                groupsnapshot.data['name'];
                                            setState(() {});
                                          },
                                          child: Material(
                                            elevation: 5,
                                            shadowColor: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              width: 120,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: currentGroupName ==
                                                          groupsnapshot.data
                                                              .get('name')
                                                      ? Color(0xff112d4e)
                                                      : Colors.blue,
                                                  width: currentGroupName ==
                                                          groupsnapshot.data
                                                              .get('name')
                                                      ? 2.5
                                                      : 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    "$groupname",
                                                    overflow: TextOverflow.fade,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff112d4e),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  },
                                );
                              }
                            }
                          },
                        ),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
            Divider(
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[50],
                  ),
                  width: 400,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder(
                        stream: DatabaseService()
                            .groupCollection
                            .doc(currentGroupID)
                            .collection('books')
                            .snapshots(),
                        builder: (context, AsyncSnapshot booksnapshot) {
                          if (booksnapshot.connectionState ==
                              ConnectionState.active) {
                            return Container(
                              width: 200,
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(vertical: 0),
                                itemCount: booksnapshot.data.docs.length + 1,
                                itemBuilder: (context, index) {
                                  if (currentGroupName != "") {
                                    if (index == 0) {
                                      return GestureDetector(
                                        onTap: () {
                                          showUploadBook(context);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            elevation: 2,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  100 *
                                                  6,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Icon(Icons.upload),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        height: 10,
                                        width: 10,
                                        color: Colors.blue,
                                      );
                                    }
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void showCreateGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 100 * 30,
              width: MediaQuery.of(context).size.width / 100 * 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create group",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: groupNameCtrl,
                      onChanged: (value) {},
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height / 100 * 0,
                            horizontal: 10.0),
                        labelText: 'Groupname',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8)),
                            height:
                                MediaQuery.of(context).size.height / 100 * 5.5,
                            width: MediaQuery.of(context).size.width / 100 * 25,
                            child: Center(
                                child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          DatabaseService().createGroup(
                              groupNameCtrl.text.trim(),
                              FirebaseAuth.instance.currentUser!.uid);
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8)),
                            height:
                                MediaQuery.of(context).size.height / 100 * 5.5,
                            width: MediaQuery.of(context).size.width / 100 * 25,
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showJoinGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 100 * 20,
              width: MediaQuery.of(context).size.width / 100 * 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Join group",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: groupIDCtrl,
                      onChanged: (value) {},
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height / 100 * 0,
                            horizontal: 10.0),
                        labelText: 'Group ID',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8)),
                            height:
                                MediaQuery.of(context).size.height / 100 * 5.5,
                            width: MediaQuery.of(context).size.width / 100 * 25,
                            child: Center(
                                child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          DatabaseService().joinGroup(groupIDCtrl.text.trim(),
                              FirebaseAuth.instance.currentUser!.uid);
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8)),
                            height:
                                MediaQuery.of(context).size.height / 100 * 5.5,
                            width: MediaQuery.of(context).size.width / 100 * 25,
                            child: Center(
                                child: Text(
                              "Join",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showUploadBook(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 100 * 18,
              width: MediaQuery.of(context).size.width / 100 * 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: StatefulBuilder(builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: DatabaseService()
                              .dataCollection
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('books')
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.active)
                              return CircularProgressIndicator();
                            else {
                              if (snapshot.data!.docs.length == 0) {
                                return Container(
                                  child: Text("You have no books to upload"),
                                );
                              } else {
                                DocumentSnapshot snap = snapshot.data!.docs[0];
                                String currentBookName = snap.id;
                                print(currentBookName);
                                List<DropdownMenuItem> bookItems = [];

                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  DocumentSnapshot snap =
                                      snapshot.data!.docs[i];
                                  bookItems.add(
                                    DropdownMenuItem(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                return Container(
                                  width: MediaQuery.of(context).size.width /
                                      100 *
                                      40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[100],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.bookmarks,
                                            size: 20.0,
                                            color: Color(0xff112d4e)),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton<dynamic>(
                                            isExpanded: false,
                                            dropdownColor: Color(0xffdbe2ef),
                                            items: bookItems,
                                            onChanged: (bookValue) {
                                              setState(() {
                                                currentBookName = bookValue;
                                              });
                                            },
                                            value: currentBookName,
                                            elevation: 5,
                                            underline: null,
                                            hint: new Text(
                                              "Choose Book",
                                              style: TextStyle(
                                                  color: Color(0xff112d4e)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8)),
                          height:
                              MediaQuery.of(context).size.height / 100 * 5.5,
                          width: MediaQuery.of(context).size.width / 100 * 25,
                          child: Center(
                              child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          print(currentBookName);
                          DatabaseService().addBookToGroup(
                              currentGroupID!,
                              FirebaseAuth.instance.currentUser!.uid,
                              currentBookName);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Color(0xff112d4e),
                            content: const Text('Uploaded successfully'),
                            duration: const Duration(seconds: 5),
                            action: SnackBarAction(
                              label: 'Dismiss',
                              onPressed: () async {
                                ScaffoldMessenger.of(context).clearSnackBars();
                              },
                            ),
                          ));
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8)),
                            height:
                                MediaQuery.of(context).size.height / 100 * 5.5,
                            width: MediaQuery.of(context).size.width / 100 * 25,
                            child: Center(
                                child: Text(
                              "Upload",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
