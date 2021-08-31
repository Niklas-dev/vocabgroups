import 'package:animate_icons/animate_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import 'package:vocalgroups/Authentication/Database.dart';

class GroupsTab extends StatefulWidget {
  @override
  _GroupsTabState createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab>
    with SingleTickerProviderStateMixin {
  TextEditingController groupNameCtrl = TextEditingController();
  TextEditingController groupIDCtrl = TextEditingController();

  late AnimateIconController controller;
  bool isPlaying = false;

  String? currentGroupID = "EozOyVtmPPbBh2QoOOEr";
  String? currentGroupName = "";

  bool createButtonOnClicked = false;

  List groups = [];

  String currentBookName = "";
  String bookToUpload = "";
  updateStatePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onTanslator', false);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimateIconController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updateStatePage();
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
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  "Click to select",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff112d4e),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6),
              child: Container(
                height: MediaQuery.of(context).size.height / 100 * 15,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: DatabaseService()
                      .dataCollection
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.get('groupID').length + 1,
                            itemBuilder: (context, index) {
                              final groupdata = snapshot.data;
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
                                    if (groupsnapshot.hasData) {
                                      String groupname =
                                          groupsnapshot.data.get('name');
                                      return Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentGroupID =
                                                  groupdata['groupID']
                                                      [index - 1];

                                              currentGroupName =
                                                  groupsnapshot.data['name'];
                                            });
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
                            }),
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
            if (currentGroupName != "")
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 4),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: Colors.grey[50],
                        ),
                        width: MediaQuery.of(context).size.width / 100 * 85,
                        height: MediaQuery.of(context).size.height / 100 * 36.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: StreamBuilder(
                                stream: DatabaseService()
                                    .groupCollection
                                    .doc(currentGroupID)
                                    .collection('books')
                                    .snapshots(),
                                builder: (context, AsyncSnapshot booksnapshot) {
                                  if (booksnapshot.hasData) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width /
                                          100 *
                                          80,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              35,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        itemCount:
                                            booksnapshot.data.docs.length + 1,
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
                                                        BorderRadius.circular(
                                                            10),
                                                    elevation: 2,
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              100 *
                                                              6,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child:
                                                            Icon(Icons.upload),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              String bookNameInGroup =
                                                  booksnapshot
                                                          .data.docs[index - 1]
                                                      ["bookname"];
                                              return Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  elevation: 2,
                                                  child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              100 *
                                                              12,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 12.0),
                                                        child: Column(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                bookNameInGroup,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            IconButton(
                                                              onPressed: () {
                                                                if (controller
                                                                    .isStart()) {
                                                                  controller
                                                                      .animateToEnd();
                                                                }
                                                                DatabaseService().getBookFromGroup(
                                                                    currentGroupID!,
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid,
                                                                    bookNameInGroup);
                                                              },
                                                              icon:
                                                                  AnimateIcons(
                                                                      size: 30,
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              400),
                                                                      startIconColor:
                                                                          Colors
                                                                              .black,
                                                                      endIconColor:
                                                                          Colors
                                                                              .green,
                                                                      startIcon: Icons
                                                                          .download,
                                                                      endIcon: Icons
                                                                          .check,
                                                                      onStartIconPress:
                                                                          () {
                                                                        return true;
                                                                      },
                                                                      onEndIconPress:
                                                                          () {
                                                                        return false;
                                                                      },
                                                                      controller:
                                                                          controller),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ),
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Colors.grey[50],
                      ),
                      width: MediaQuery.of(context).size.width / 100 * 85,
                      height: MediaQuery.of(context).size.height / 100 * 9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    tooltip: "Close",
                                    onPressed: () async {
                                      currentGroupName = "";

                                      setState(() {});
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    tooltip: "Edit Group",
                                    onPressed: () {
                                      showGroupInfo(context);
                                    },
                                    icon: Icon(Icons.info_outline),
                                  ),
                                  IconButton(
                                    tooltip: "Leave Group",
                                    onPressed: () async {
                                      askForLeaveGroup(context);
                                    },
                                    icon: Icon(Icons.exit_to_app),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            if (currentGroupName == "")
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 100 * 36.5,
                  width: MediaQuery.of(context).size.width / 100 * 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/community.png'))),
                ),
              ),
          ],
        ));
  }

  void showGroupInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 100 * 50,
              width: MediaQuery.of(context).size.width / 100 * 100,
              child: StatefulBuilder(builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Group Informations",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Group ID:",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            currentGroupID!,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Clipboard.setData(
                                        new ClipboardData(text: currentGroupID))
                                    .then((_) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Color(0xff112d4e),
                                    content:
                                        const Text('ID copied successfully'),
                                    duration: const Duration(seconds: 3),
                                  ));
                                });
                              },
                              child: Text("Copy ID")),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: DatabaseService()
                          .groupCollection
                          .doc(currentGroupID!)
                          .snapshots(),
                      builder: (context, AsyncSnapshot membersnapshot) {
                        if (membersnapshot.hasData) {
                          return Container(
                            height:
                                MediaQuery.of(context).size.width / 100 * 55,
                            width: MediaQuery.of(context).size.width / 100 * 80,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  membersnapshot.data.get('members').length,
                              itemBuilder: (context, index) {
                                String membername =
                                    membersnapshot.data.get('members')[index];
                                String leadername =
                                    membersnapshot.data.get('leader');
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(6),
                                    child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /
                                          100 *
                                          80,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child:
                                                    Icon(Icons.account_circle),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    100 *
                                                    45,
                                                child: Text(
                                                  membername,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (membername == leadername)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                    color: Colors.green,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Text(
                                                    "Admin",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
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
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14.0, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8)),
                              height: MediaQuery.of(context).size.height /
                                  100 *
                                  5.5,
                              width:
                                  MediaQuery.of(context).size.width / 100 * 25,
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
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
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
                          onTap: () {
                            groupNameCtrl.clear();
                            Navigator.of(context).pop();
                          },
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
                          groupNameCtrl.clear();
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
                          onTap: () {
                            groupNameCtrl.clear();
                            Navigator.of(context).pop();
                          },
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
              height: MediaQuery.of(context).size.height / 100 * 22,
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
                                  width: MediaQuery.of(context).size.width /
                                      100 *
                                      40,
                                  height: MediaQuery.of(context).size.height /
                                      100 *
                                      5,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[50],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No books to upload",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                DocumentSnapshot snap = snapshot.data!.docs[0];
                                currentBookName = snap.id;

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
                                return StatefulBuilder(
                                    builder: (context, setState) {
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
                                                  bookToUpload = bookValue;
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
                                });
                              }
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  Spacer(),
                  StreamBuilder(
                    stream: DatabaseService()
                        .dataCollection
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('books')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.data!.docs.length == 0) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              5.5,
                                      width: MediaQuery.of(context).size.width /
                                          100 *
                                          25,
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
                                ],
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              5.5,
                                      width: MediaQuery.of(context).size.width /
                                          100 *
                                          25,
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
                                  SizedBox(
                                    width: 6,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      DatabaseService().addBookToGroup(
                                          currentGroupID!,
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          currentBookName);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor: Color(0xff112d4e),
                                        content:
                                            const Text('Uploaded successfully'),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'Dismiss',
                                          onPressed: () async {
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars();
                                          },
                                        ),
                                      ));
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              5.5,
                                      width: MediaQuery.of(context).size.width /
                                          100 *
                                          25,
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
                                ],
                              ),
                            ],
                          );
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void askForLeaveGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 100 * 15,
              width: MediaQuery.of(context).size.width / 100 * 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You want to leave the group?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8)),
                          height:
                              MediaQuery.of(context).size.height / 100 * 5.5,
                          width: MediaQuery.of(context).size.width / 100 * 25,
                          child: Center(
                              child: Text(
                            "No",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      InkWell(
                        onTap: () async {
                          DatabaseService().leaveGroup(currentGroupID!,
                              FirebaseAuth.instance.currentUser!.uid);
                          currentGroupName = "";
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Color(0xff112d4e),
                            content: const Text('Group left successfully'),
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
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(8)),
                          height:
                              MediaQuery.of(context).size.height / 100 * 5.5,
                          width: MediaQuery.of(context).size.width / 100 * 25,
                          child: Center(
                              child: Text(
                            "Yes",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
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
