import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cue/Functions/loading.dart';
import 'package:cue/login/register2.dart';
import 'package:cue/services/database.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  bool _loading = false;

  bool _success;
  String _userEmail;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 200),
                    Center(
                      child: Text(
                        'Create account',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 100),
                    createID('Email Address'),
                    createPW('Password'),
                    confirmPW('Confirm Password'),
                    createNick('Your Nickname'),
                    SizedBox(height: 20),
                    FlatButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          await _register();
                          setState(() {
                            _loading = false;
                          });
                          _success == true
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          RegisterPage2()))
                              : showSnackBar(context);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.black)),
                      child: Text('Sign up',
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget createID(String txt) {
    return Container(
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(border: InputBorder.none, hintText: txt),
        keyboardType: TextInputType.emailAddress,
      ),
      width: 300,
      height: 40,
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.black)),
    );
  }

  Widget createPW(String txt) {
    return Container(
      child: TextField(
        controller: _passwordController,
        decoration: InputDecoration(border: InputBorder.none, hintText: txt),
        obscureText: true,
      ),
      width: 300,
      height: 40,
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.black)),
    );
  }

  Widget confirmPW(String txt) {
    return Container(
      child: TextField(
        controller: _passwordController2,
        decoration: InputDecoration(border: InputBorder.none, hintText: txt),
        obscureText: true,
      ),
      width: 300,
      height: 40,
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.black)),
    );
  }

  Widget createNick(String txt) {
    return Container(
      child: TextField(
        controller: _nickNameController,
        decoration: InputDecoration(border: InputBorder.none, hintText: txt),
        keyboardType: TextInputType.emailAddress,
      ),
      width: 300,
      height: 40,
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.black)),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    _passwordController2.dispose();
    _nickNameController.dispose();
    super.dispose();
  }

  Future _register() async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      await DatabaseService(uid: user.uid)
          .createUserData(_nickNameController.text);

      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      _success = false;
    }
  }
}

void showSnackBar(BuildContext context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text('다시 진행해주세요', textAlign: TextAlign.center),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.redAccent,
  ));
}
