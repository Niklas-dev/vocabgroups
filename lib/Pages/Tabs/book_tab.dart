import 'package:flutter/material.dart';

class BookTab extends StatefulWidget {
  @override
  _BookTabState createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).padding,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 100 * 8,
            child: Material(
              elevation: 5,
              child: Text(
                'Book',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'data',
                      style: TextStyle(fontSize: 25),
                    ),
                    Container(
                      height: 40,
                      child: VerticalDivider(
                        thickness: 2,
                      ),
                    ),
                    Text(
                      'data',
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            color: Colors.blueAccent,
            height: MediaQuery.of(context).size.height / 100 * 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text("Add line"), Text("Remove Line")],
            ),
          )
        ],
      ),
    );
  }
}
