import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vocalgroups/Pages/auth/register_page.dart';
import 'package:vocalgroups/Pages/home_page.dart';
import 'package:vocalgroups/authentication.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  String _password = "";
  String _email = "";

  final auth = FirebaseAuth.instance;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage('assets/loginpagebg_2.jpg'),
          )),
          margin: MediaQuery.of(context).padding,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 100 * 6,
                          bottom: 80),
                      child: Column(
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.width / 100 * 15,
                            width: MediaQuery.of(context).size.width / 100 * 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage(
                                    'assets/logo/logo_white_large.png'),
                              ),
                            ),
                          ),
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent.withOpacity(0.4),
                          ),
                          child: TextField(
                            controller: email,
                            onChanged: (value) {
                              _email = value.trim();
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height /
                                      100 *
                                      2.5,
                                  horizontal: 10.0),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  )),
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent.withOpacity(0.4),
                          ),
                          child: TextField(
                            controller: password,
                            onChanged: (value) {
                              _password = value.trim();
                            },
                            obscureText: hidePassword,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height /
                                      100 *
                                      2.5,
                                  horizontal: 10.0),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    if (hidePassword) {
                                      hidePassword = false;
                                    } else {
                                      hidePassword = true;
                                    }
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    hidePassword
                                        ? FontAwesomeIcons.eyeSlash
                                        : FontAwesomeIcons.eye,
                                    color: Colors.white,
                                  )),
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 100 * 10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 100 * 30,
                        height: MediaQuery.of(context).size.height / 100 * 8,
                        decoration: BoxDecoration(
                          color: Colors.transparent.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () async {
                              AuthenticationService().signIn(_email, _password);
                              //email.clear();
                              //password.clear();
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 100 * 16),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                      },
                      child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.transparent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Create new account",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              //Padding(padding: EdgeInsets.only(top: 30), child: InkWell()),
            ],
          )),
    );
  }

  void isLoggedIn() async {
    if (mounted) {
      setState(() {
        auth.authStateChanges().listen((user) {
          if (user == null) {
            print('User is currently signed out!');
          } else {
            print('User is signed in!');
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          }
        });
      });
    }
  }
}
