import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  String currentBookName = "english";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService()
          .dataCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot usersnapshot) {
        if (!usersnapshot.hasData && !mounted) {
          return CircularProgressIndicator();
        } else {
          final list = usersnapshot.data;
          return Container(
            margin: MediaQuery.of(context).padding,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxHeight >= 600) {
                  return Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Your Groups",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width / 100 * 10,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 0),
                            itemCount:
                                usersnapshot.data.get('groupID').length + 1,
                            itemBuilder: (context, index) {
                              if (usersnapshot.data.get('groupID').length ==
                                  0) {
                                if (!createButtonOnClicked) {
                                  return GestureDetector(
                                    onTap: () {
                                      createButtonOnClicked = true;
                                      if (!mounted) print("not mounted");
                                      if (mounted) setState(() {});
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(10),
                                        elevation: 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: 100,
                                          child: Center(
                                            child: Icon(Icons.chat),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onLongPress: () {
                                      if (!mounted) print("not mounted");
                                      if (mounted)
                                        setState(() {
                                          createButtonOnClicked = false;
                                        });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(6),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(10),
                                        elevation: 5,
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: 100,
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (!mounted)
                                                      print("not mounted");
                                                    if (mounted)
                                                      setState(() {
                                                        createButtonOnClicked =
                                                            false;
                                                      });
                                                    showCreateGroup(context);
                                                  },
                                                  child: Container(
                                                      child: Icon(
                                                          Icons.group_add)),
                                                ),
                                                Divider(
                                                  indent: 15,
                                                  endIndent: 15,
                                                  color: Colors.black,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (!mounted)
                                                      print("not mounted");
                                                    if (mounted)
                                                      setState(() {
                                                        createButtonOnClicked =
                                                            false;
                                                      });
                                                    showJoinGroup(context);
                                                  },
                                                  child: Container(
                                                      child:
                                                          Icon(Icons.groups)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                if (index == 0) {
                                  if (!createButtonOnClicked) {
                                    return GestureDetector(
                                      onTap: () {
                                        createButtonOnClicked = true;
                                        if (!mounted) print("not mounted");
                                        if (mounted) setState(() {});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          elevation: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            width: 100,
                                            child: Center(
                                              child: Icon(Icons.chat),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onLongPress: () {
                                        if (!mounted) print("not mounted");
                                        if (mounted)
                                          setState(() {
                                            createButtonOnClicked = false;
                                          });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          elevation: 5,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            width: 100,
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (!mounted)
                                                        print("not mounted");
                                                      setState(() {
                                                        createButtonOnClicked =
                                                            false;
                                                      });
                                                      showCreateGroup(context);
                                                    },
                                                    child: Container(
                                                        child: Icon(
                                                            Icons.group_add)),
                                                  ),
                                                  Divider(
                                                    indent: 15,
                                                    endIndent: 15,
                                                    color: Colors.black,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (!mounted) return;
                                                      setState(() {
                                                        createButtonOnClicked =
                                                            false;
                                                      });
                                                      showJoinGroup(context);
                                                    },
                                                    child: Container(
                                                        child:
                                                            Icon(Icons.groups)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return StreamBuilder(
                                    stream: DatabaseService()
                                        .groupCollection
                                        .doc(list['groupID'][index - 1])
                                        .snapshots(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      print(snapshot.data['name']);
                                      if (!snapshot.hasData) {
                                        return Container(
                                          child: Text("Loading DATA..."),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            currentGroupID =
                                                list['groupID'][index - 1];
                                            currentGroupName =
                                                snapshot.data['name'];
                                            if (mounted) setState(() {});
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              elevation: 5,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  border: Border.all(
                                                      color: currentGroupName ==
                                                              snapshot.data
                                                                  .get('name')
                                                          ? Colors.blueAccent
                                                          : Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                width: 100,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(snapshot.data
                                                        .get('name')),
                                                    IconButton(
                                                        onPressed: () async {
                                                          print("sus");
                                                          print(
                                                              "removed: $currentGroupID}");
                                                        },
                                                        icon: Icon(Icons
                                                            .leave_bags_at_home))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          indent: 60,
                          endIndent: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(currentGroupName!),
                          ),
                        ),
                        StreamBuilder(
                            stream: DatabaseService()
                                .groupCollection
                                .doc(currentGroupID)
                                .collection('books')
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Container(
                                  child: Text("No Data"),
                                );
                              } else {
                                return Container(
                                  height: 300,
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      itemCount: snapshot.data.docs.length + 1,
                                      itemBuilder: (context, index) {
                                        if (currentGroupName != "") {
                                          if (index ==
                                              snapshot.data.docs.length) {
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
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            100 *
                                                            6,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[100],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: Icon(Icons.upload),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        } else {
                                          return Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Select or Create a group",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          );
                                        }

                                        if (!groups.contains(snapshot
                                            .data.docs[index]['bookname'])) {
                                          groups.add(snapshot.data.docs[index]
                                              ['bookname']);
                                        }

                                        return GestureDetector(
                                          onTap: () {
                                            debugPrint("uplaod");
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
                                                  child: Text(snapshot.data
                                                      .docs[index]['bookname']),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              }
                            }),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Your Groups",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 0),
                            itemCount:
                                usersnapshot.data.get('groupID').length + 1,
                            itemBuilder: (context, index) {
                              if (usersnapshot.data.get('groupID').length ==
                                  0) {
                                if (!createButtonOnClicked) {
                                  return GestureDetector(
                                    onTap: () {
                                      createButtonOnClicked = true;
                                      if (!mounted) return;
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(10),
                                        elevation: 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: 100,
                                          child: Center(
                                            child: Icon(Icons.chat),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onLongPress: () {
                                      if (!mounted) return;
                                      setState(() {
                                        createButtonOnClicked = false;
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(6),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(10),
                                        elevation: 5,
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: 100,
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (!mounted) return;
                                                    setState(() {
                                                      createButtonOnClicked =
                                                          false;
                                                    });
                                                    showCreateGroup(context);
                                                  },
                                                  child: Container(
                                                      child: Icon(
                                                          Icons.group_add)),
                                                ),
                                                Divider(
                                                  indent: 15,
                                                  endIndent: 15,
                                                  color: Colors.black,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (!mounted) return;
                                                    setState(() {
                                                      createButtonOnClicked =
                                                          false;
                                                    });
                                                    showJoinGroup(context);
                                                  },
                                                  child: Container(
                                                      child:
                                                          Icon(Icons.groups)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                if (index == 0) {
                                  if (!createButtonOnClicked) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (!mounted) return;
                                        createButtonOnClicked = true;
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          elevation: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            width: 100,
                                            child: Center(
                                              child: Icon(Icons.chat),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onLongPress: () {
                                        if (!mounted) return;
                                        setState(() {
                                          createButtonOnClicked = false;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          elevation: 5,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            width: 100,
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (!mounted) return;
                                                      setState(() {
                                                        createButtonOnClicked =
                                                            false;
                                                      });
                                                      showCreateGroup(context);
                                                    },
                                                    child: Container(
                                                        child: Icon(
                                                            Icons.group_add)),
                                                  ),
                                                  Divider(
                                                    indent: 15,
                                                    endIndent: 15,
                                                    color: Colors.black,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (!mounted) return;
                                                      setState(() {
                                                        createButtonOnClicked =
                                                            false;
                                                      });
                                                      showJoinGroup(context);
                                                    },
                                                    child: Container(
                                                        child:
                                                            Icon(Icons.groups)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return StreamBuilder(
                                    stream: DatabaseService()
                                        .groupCollection
                                        .doc(list['groupID'][index - 1])
                                        .snapshots(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container(
                                          child: Text("Loading DATA..."),
                                        );
                                      } else {
                                        return Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            elevation: 5,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              width: 100,
                                              child: Center(
                                                child: Text(
                                                    snapshot.data.get('name')),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }

  getFirstGroup() async {
    currentGroupName = groups[0];
    if (mounted) setState(() {});
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
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            else {
                              List<DropdownMenuItem> bookItems = [];
                              for (int i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                DocumentSnapshot snap = snapshot.data!.docs[i];
                                bookItems.add(
                                  DropdownMenuItem(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          100 *
                                          25,
                                      child: Text(
                                        snap.id,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.bookmarks,
                                          size: 20.0, color: Color(0xff112d4e)),
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
