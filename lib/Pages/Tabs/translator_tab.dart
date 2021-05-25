import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslatorTab extends StatefulWidget {
  @override
  _TranslatorTabState createState() => _TranslatorTabState();
}

class _TranslatorTabState extends State<TranslatorTab> {
  final translator = GoogleTranslator();

  TextEditingController inputLang = TextEditingController();
  TextEditingController outputLang = TextEditingController();

  String firstLanguage = 'German';
  String secondLanguage = 'English';

  int firstIndex = 0;
  int secondIndex = 0;

  final List<String> allLanguages = ['English', 'German', 'Italian', 'French'];

  final List<String> languageCodes = ['en', 'de', 'it', 'fr'];

  void initState() {
    super.initState();
  }

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
                  color: Color(0xff112d4e),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: DropdownButton(
                          value: firstLanguage,
                          icon: const Icon(Icons.language),
                          iconSize: 20,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          underline: Container(
                            height: 1,
                            color: Color(0xff112d4e),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              firstLanguage = newValue!;
                              firstIndex = allLanguages.indexOf(newValue);
                            });
                          },
                          items: allLanguages
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(value),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.mic))
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        child: TextField(
                          controller: inputLang,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: DropdownButton(
                          value: secondLanguage,
                          icon: const Icon(Icons.language),
                          iconSize: 20,
                          elevation: 1,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          underline: Container(
                            height: 1,
                            color: Color(0xff112d4e),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              secondLanguage = newValue!;
                              secondIndex = allLanguages.indexOf(newValue);
                            });
                          },
                          items: allLanguages
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(value),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.headphones))
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        child: TextField(
                          controller: outputLang,
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
                  InkWell(
                    onTap: () async {
                      outputLang.text = await translate();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffdbe2ef)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Translate",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff112d4e),
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<String> translate() async {
    Translation translation = await translator.translate(inputLang.text.trim(),
        to: languageCodes[secondIndex]);
    outputLang.text = translation.text;
    return translation.text;
  }
}
