import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cue/Functions/loading.dart';
import 'package:cue/screen/login/forget_page.dart';
import 'package:cue/screen/login/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LogIn()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    final double mh = MediaQuery.of(context).size.height;
    final double mw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: mh * 0.23,
          ),
          Row(
            children: [
              SizedBox(width: mw * 0.1),
              Image.asset('images/cueLogo1.png'),
            ],
          ),
          SizedBox(
            height: mh * 0.57,
          ),
          Text(
            'ⓒ 2020. Cue Team all rights reserved',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _success;
  bool _loading = false;
  String _userEmail;
  String _email = '';
  String _pw = '';
  SharedPreferences _prefs;
  @override
  void initState() {
    super.initState();
    _loadId();
  }

  _loadId() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (_prefs.getString('email') ?? '');
      _pw = (_prefs.getString('pw') ?? '');
      _emailController.text = _prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    final double mh = MediaQuery.of(context).size.height;
    final double mw = MediaQuery.of(context).size.width;

    return _loading
        ? Loading()
        : Scaffold(
            body: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: mh * 0.2)),
                        Center(
                          child: Text(
                            'Cue!',
                            style: TextStyle(
                                fontFamily: 'Rochester',
                                letterSpacing: 2.0,
                                fontSize: 60.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF9700)),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Theme(
                            data: ThemeData(
                                primaryColor: Colors.transparent,
                                inputDecorationTheme: InputDecorationTheme(
                                    labelStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 15.0))),
                            child: Container(
                              padding: EdgeInsets.only(top: mh * 0.15),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: mw * 0.036),
                                    height: mh * 0.07,
                                    width: mw * 0.78,
                                    child: TextField(
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'ID',
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress),
                                    decoration: BoxDecoration(
                                        border:
                                            new Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                  ),
                                  SizedBox(
                                    height: mh * 0.015,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: mw * 0.036),
                                    height: mh * 0.07,
                                    width: mw * 0.78,
                                    child: TextField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: InputBorder.none,
                                        hintText: 'Password',
                                      ),
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                    ),
                                    decoration: BoxDecoration(
                                        border:
                                            new Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                  ),
                                  SizedBox(height: mh * 0.045),
                                  ButtonTheme(
                                      minWidth: mw * 0.243,
                                      height: mh * 0.059,
                                      child: Container(
                                        child: FlatButton(
                                          color: Colors.transparent,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                            size: mw * 0.073,
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              setState(() {
                                                _loading = true;
                                              });
                                              _email = _emailController.text;
                                              _pw = _passwordController.text;
                                              _prefs.setString('email', _email);
                                              _prefs.setString('pw', _pw);
                                              _signInWithEmailAndPassword();
                                            }
                                          },
                                        ),
                                        decoration: BoxDecoration(
                                            border: new Border.all(
                                                color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(13.0))),
                                      )),
                                  SizedBox(
                                    height: mh * 0.088,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        child: Text(
                                          '비밀번호 찾기',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          Forget_page()));
                                        },
                                      ),
                                      SizedBox(
                                        width: mw * 0.012,
                                      ),
                                      Container(
                                        child: Text(
                                          '/',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                      SizedBox(
                                        width: mw * 0.012,
                                      ),
                                      InkWell(
                                        child: Text(
                                          '회원가입',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          RegisterPage()));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  // Example code of how to sign in with email and password.
  void _signInWithEmailAndPassword() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User user;

    user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
        _loading = false;
      });
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (BuildContext context) => MainPage()));
      Navigator.pop(context);
    } else {
      _success = false;
      showSnackBar(context);
    }
  }
}

void showSnackBar(BuildContext context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text('아이디, 혹은 비밀번호를 확인하세요', textAlign: TextAlign.center),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.redAccent,
  ));
}
