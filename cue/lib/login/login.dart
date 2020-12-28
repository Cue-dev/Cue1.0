import 'package:flutter/material.dart';
import 'package:cue/Functions/loading.dart';
import 'package:cue/Home/mainPage.dart';
import 'package:cue/login/forget_page.dart';
import 'package:cue/login/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
User user;

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
                        Padding(padding: EdgeInsets.only(top: 140)),
                        Center(
                          child: Text(
                            'Cue!',
                            style: GoogleFonts.lato(
//                                fontFamily: 'Rochester',
                                letterSpacing: 2.0,
                                fontSize: 60.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange
                            ),
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
                              padding: EdgeInsets.only(top: 100),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                //    color: Colors.orange,
                                    padding: EdgeInsets.only(left: 15),
                                    height: 50,
                                    width: 320,
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
                                    height: 10.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 15),
                                    height: 50,
                                    width: 320,
                                    child: TextField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                      ),
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                    ),
                                    decoration: BoxDecoration(
                                        border: new Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                  ),
                                  SizedBox(height: 30.0),
                                  ButtonTheme(
                                      minWidth: 100.0,
                                      height: 40.0,
                                      child: Container(
                                        child: FlatButton(
                                          color: Colors.transparent,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                            size: 30.0,
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
                                    height: 60,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        child: Text(
                                          '비밀번호 찾기',
                                          style: TextStyle(
                                            color: Colors.orangeAccent,
                                          ),
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
                                        width: 5,
                                      ),
                                      Container(
                                        child: Text(
                                          '/',
                                          style: TextStyle(
                                            color: Colors.orangeAccent,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        child: Text(
                                          '회원가입',
                                          style: TextStyle(
                                            color: Colors.orangeAccent,
                                          ),
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
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => MainPage()));
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
