import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('data');
  CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  Future updateUserData(String username, String email) async {
    List<String> groupIDs = [];
    return await dataCollection.doc(uid).set({
      'username': username,
      'email': email,
      'groupID': FieldValue.arrayUnion(groupIDs),
    });
  }

  Stream<QuerySnapshot> get data {
    return dataCollection.snapshots();
  }

  Future createGroup(String groupName, String userUID) async {
    List<String> members = [];
    members.add(userUID);

    List<String> groupIDs = [];

    try {
      DocumentReference docref = await groupCollection.add({
        'name': groupName,
        'leader': userUID,
        'members': members,
      });
      groupIDs.add(docref.id);
      await dataCollection.doc(userUID).update({
        'groupID': FieldValue.arrayUnion(groupIDs),
      });
    } catch (e) {}
  }

  Future joinGroup(String groupID, String userUID) async {
    List<String> members = [];
    members.add(userUID);

    List<String> groupIDs = [];
    groupIDs.add(groupID);

    try {
      await groupCollection
          .doc(groupID)
          .update({'members': FieldValue.arrayUnion(members)});
      await dataCollection.doc(userUID).update({
        'groupID': FieldValue.arrayUnion(groupIDs),
      });
    } catch (e) {}
  }

  Future addBookToGroup(String groupID, String userUID, String bookname) async {
    DocumentSnapshot userbooks = await DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .doc(bookname)
        .get();

    String uploadbookname = userbooks['bookname'];
    //int uploadbookindex = userbooks['index'];
    //bool uploadbookpublic = userbooks['public'];
    String uploadbookleftColumnName = userbooks['leftColumnName'];
    String uploadbookrightColumnName = userbooks['rightColumnName'];
    List uploadbookleftContent = userbooks['leftContent'];
    List uploadbookrightContent = userbooks['rightContent'];

    try {
      await groupCollection.doc(groupID).collection('books').doc(bookname).set({
        'bookname': uploadbookname,
        'index': null,
        'public': null,
        'leftColumnName': uploadbookleftColumnName,
        'rightColumnName': uploadbookrightColumnName,
        'leftContent': uploadbookleftContent,
        'rightContent': uploadbookrightContent,
      });
    } catch (e) {}
  }

  Future leaveGroup(String groupID, String userUID) async {
    List<String> members = [];
    members.remove(userUID);

    List<String> groupIDs = [];
    groupIDs.remove(groupID);

    try {
      print("ids $groupIDs");

      await dataCollection.doc(userUID).update({
        'groupID': groupIDs,
      });
    } catch (e) {}
  }
}
