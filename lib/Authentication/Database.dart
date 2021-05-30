import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('data');

  Future updateUserData(String username, String email) async {
    return await dataCollection.doc(uid).set({
      'username': username,
      'email': email,
    });
  }

  Stream<QuerySnapshot> get data {
    return dataCollection.snapshots();
  }
}
