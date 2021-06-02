import 'package:flutter/material.dart';
import 'package:vocalgroups/Utilis/book.dart';

class BooksTab extends StatefulWidget {
  @override
  _BooksTabState createState() => _BooksTabState();
}

class _BooksTabState extends State<BooksTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).padding,
      child: Container(
        color: Colors.yellow,
        child: IconButton(
          onPressed: () {
            Book().addBook('English1', false, 0);
          },
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
