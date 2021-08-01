import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class TranslatorTab extends StatefulWidget {
  @override
  _TranslatorTabState createState() => _TranslatorTabState();
}

class _TranslatorTabState extends State<TranslatorTab> {
  final translator = GoogleTranslator();

  TextEditingController inputLang = TextEditingController();
  TextEditingController outputLang = TextEditingController();

  String firstLanguage = 'Language recognize';
  String secondLanguage = 'English';

  int firstIndex = 0;
  int secondIndex = 0;

  final List<String> allLanguages = [
    'Language recognize',
    'English',
    'German',
    'Italian',
    'French'
  ];

  final List<String> allLanguagesSecond = [
    'English',
    'German',
    'Italian',
    'French',
  ];

  final List<String> languageCodes = [
    'Language recognize',
    'en',
    'de',
    'it',
    'fr',
  ];

  final List<String> languageCodesSecond = [
    'en',
    'de',
    'it',
    'fr',
  ];

  void initState() {
    super.initState();
  }

  updateStatePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onTanslator', true);
  }

  @override
  Widget build(BuildContext context) {
    updateStatePage();
    return Container(
      margin: MediaQuery.of(context).padding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                width: MediaQuery.of(context).size.width / 100 * 95,
                height: MediaQuery.of(context).size.height / 100 * 8,
                decoration: BoxDecoration(
                  color: const Color(0xff3F72AF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      'Translator',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                    ),
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
                color: Colors.white,
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
                            icon: Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Icon(Icons.language),
                            ),
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
                          color: Colors.white,
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
                            icon: Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Icon(Icons.language),
                            ),
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
                                secondIndex =
                                    allLanguagesSecond.indexOf(newValue);
                              });
                            },
                            items: allLanguagesSecond
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
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.headphones))
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          color: Colors.white,
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
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: InkWell(
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
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 100 * 32,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage('assets/translate.png'),
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> translate() async {
    Translation translation = await translator.translate(inputLang.text.trim(),
        to: languageCodesSecond[secondIndex]);

    if (allLanguages[firstIndex] == "Language recognize") {
      translation = await translator.translate(inputLang.text.trim(),
          to: languageCodesSecond[secondIndex]);
    } else {
      translation = await translator.translate(inputLang.text.trim(),
          from: languageCodes[firstIndex],
          to: languageCodesSecond[secondIndex]);
    }

    outputLang.text = translation.text;
    return translation.text;
  }
}
