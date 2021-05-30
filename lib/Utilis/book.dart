import 'package:firebase_auth/firebase_auth.dart';
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
  }

  addBook(String bookname, bool public, int index) {
    DatabaseService()
        .dataCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .doc()
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

  List<String> rightContent() {
    return ['', ''];
  }
}
