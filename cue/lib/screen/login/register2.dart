import 'package:flutter/material.dart';
import 'package:cue/screen/login/login.dart';

class RegisterPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      SizedBox(height: 320),
      Center(
        child: Text(
          '회원가입 성공!',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      SizedBox(
        height: 80,
      ),
      ButtonTheme(
          minWidth: 80.0,
          height: 15.0,
          child: Container(
            child: FlatButton(
              color: Colors.transparent,
              child: Text(
                '로그인',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LogIn()));
              },
            ),
            decoration: BoxDecoration(
                border: new Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(13.0))),
          )),
    ]));
  }
}
