import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocalgroups/Authentication/Database.dart';

class Book {
  String? bookname;
  bool? public;
  int? index;

  Book({
    this.bookname,
    this.public,
    this.index,
  });

  printData() {
    print(bookname);
    print(public);
    print(index);
    print("Book");
  }

  addBook(String bookname, bool public, int index) {
    DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .doc(bookname)
        .set({
      'bookname': bookname,
      'public': public,
      'index': index,
      'leftColumnName': 'Left',
      'rightColumnName': 'Right',
      'leftContent': <String>['Hallo', 'Bye'],
      'rightContent': <String>['Hello', 'Tschau'],
    });
  }

  Future<int> getBooksAmount() async {
    int amount = 0;
    QuerySnapshot snapshot = await DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .get();

    amount = snapshot.docs.length;
    return amount;
  }

  addBookRow(
      String bookname, String leftRowString, String rightRowString) async {
    List<String> oldLeftContent = [];
    List<String> oldRightContent = [];

    List<String>? newLeftContent;
    List<String>? newRightContent;
    DocumentSnapshot snapshot = await DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .doc(bookname)
        .get();
    for (String item in snapshot.get('leftContent')) {
      oldLeftContent.add(item);
    }
    for (String item in snapshot.get('rightContent')) {
      oldRightContent.add(item);
    }

    if (leftRowString == "" || rightRowString == "") {
      leftRowString = "Empty";
      rightRowString = "Empty";
    }
    oldLeftContent.add(leftRowString);
    newLeftContent = oldLeftContent;

    oldRightContent.add(rightRowString);
    newRightContent = oldRightContent;

    DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .doc(bookname)
        .set({
      'bookname': bookname,
      'public': public,
      'index': index,
      'leftColumnName': 'Left',
      'rightColumnName': 'Right',
      'leftContent': newLeftContent,
      'rightContent': newRightContent,
    });

    //print(oldLeftContent);
  }

  removeBookRow(String bookname, int rowIndex) async {
    List<String> oldLeftContent = [];
    List<String> oldRightContent = [];

    List<String>? newLeftContent;
    List<String>? newRightContent;
    DocumentSnapshot snapshot = await DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .doc(bookname)
        .get();
    for (String item in snapshot.get('leftContent')) {
      oldLeftContent.add(item);
    }

    for (String item in snapshot.get('rightContent')) {
      oldRightContent.add(item);
    }
    print(rowIndex);
    print(oldLeftContent);

    oldLeftContent.removeAt(rowIndex);
    oldRightContent.removeAt(rowIndex);

    newLeftContent = oldLeftContent;
    newRightContent = oldRightContent;

    DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .doc(bookname)
        .set({
      'bookname': bookname,
      'public': public,
      'index': index,
      'leftColumnName': 'Left',
      'rightColumnName': 'Right',
      'leftContent': newLeftContent,
      'rightContent': newRightContent,
    });
  }

  List<String> rightContent() {
    return ['', ''];
  }
}
