import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cue/Home/mainPage.dart';
import 'package:cue/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'voingLogIn',
      home: MainPage(),
    );
  }
}
