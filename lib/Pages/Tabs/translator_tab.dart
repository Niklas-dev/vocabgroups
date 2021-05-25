import 'package:flutter/material.dart';

class TranslatorTab extends StatefulWidget {
  @override
  _TranslatorTabState createState() => _TranslatorTabState();
}

class _TranslatorTabState extends State<TranslatorTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: MediaQuery.of(context).padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Translator",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 50,
                left: 5,
                right: 5,
              ),
              child: Material(
                elevation: 5,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        TextField(
                          minLines: 5,
                          maxLines: 5,
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                    ),
                    Stack(
                      children: [
                        TextField(
                          readOnly: true,
                          minLines: 5,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Translation',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
