import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

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
