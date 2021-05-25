import 'package:flutter/material.dart';

class TranslatorTab extends StatefulWidget {
  @override
  _TranslatorTabState createState() => _TranslatorTabState();
}

class _TranslatorTabState extends State<TranslatorTab> {
  String firstLanguage = 'German';
  String secondLanguage = 'English';
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: MediaQuery.of(context).padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 100 * 2.5),
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
                top: MediaQuery.of(context).size.height / 100 * 5,
                left: 5,
                right: 5,
              ),
              child: Material(
                elevation: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: DropdownButton(
                        value: firstLanguage,
                        icon: const Icon(Icons.language),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            firstLanguage = newValue!;
                          });
                        },
                        items: <String>[
                          'English',
                          'German',
                          'Italian',
                          'French'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 100,
                          child: TextField(
                            minLines: 4,
                            maxLines: 4,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              contentPadding: EdgeInsets.all(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: DropdownButton(
                        value: secondLanguage,
                        icon: const Icon(Icons.language),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            secondLanguage = newValue!;
                          });
                        },
                        items: <String>[
                          'English',
                          'German',
                          'Italian',
                          'French'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 100,
                          child: TextField(
                            readOnly: true,
                            minLines: 4,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'Translation...',
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              contentPadding: EdgeInsets.all(5),
                            ),
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
