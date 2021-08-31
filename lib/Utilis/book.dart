import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vocalgroups/Authentication/Database.dart';

class Book {
  String? bookname;
  bool? public;
  int? index;
  String? currentBook;
  String? lastbook;

  Book({
    this.bookname,
    this.public,
    this.index,
    this.currentBook,
    this.lastbook,
  });

  addBook(String bookname, bool public, int index, String leftColumnName,
      String rightColumnName) {
    DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .doc(bookname)
        .set({
      'bookname': bookname,
      'public': public,
      'index': index,
      'leftColumnName': leftColumnName,
      'rightColumnName': rightColumnName,
      'leftContent': <String>['Use the add Button'],
      'rightContent': <String>['to add more rows'],
    });
  }

  editBook(String oldbookname, String bookname, String leftColumnName,
      String rightColumnName, bool public, int index) {
    if (bookname != "") {
      DatabaseService()
          .dataCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('books')
          .doc(oldbookname)
          .set({
        'bookname': bookname,
      });
    }
    if (leftColumnName != "") {
      DatabaseService()
          .dataCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('books')
          .doc(oldbookname)
          .set({
        'leftColumnName': leftColumnName,
      });
    }
    if (rightColumnName != "") {
      DatabaseService()
          .dataCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('books')
          .doc(oldbookname)
          .set({
        'rightColumnName': rightColumnName,
      });
    }
    /*DatabaseService()
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
      'leftContent': <String>['Use the add Button'],
      'rightContent': <String>['to add more rows'],
    });*/
  }

  deleteBook(String bookname) {
    DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .doc(bookname)
        .delete();
  }

  getBooksAmount() async {
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

    String leftName = "";
    String rightName = "";

    DocumentSnapshot snapshot = await DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .doc(bookname)
        .get();

    leftName = snapshot.get('leftColumnName');
    rightName = snapshot.get('rightColumnName');

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
      'leftColumnName': leftName,
      'rightColumnName': rightName,
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

    String leftName = "";
    String rightName = "";

    DocumentSnapshot snapshot = await DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .doc(bookname)
        .get();

    leftName = snapshot.get('leftColumnName');
    rightName = snapshot.get('rightColumnName');

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
      'leftColumnName': leftName,
      'rightColumnName': rightName,
      'leftContent': newLeftContent,
      'rightContent': newRightContent,
    });
  }

  List<String> rightContent() {
    return ['', ''];
  }
}
