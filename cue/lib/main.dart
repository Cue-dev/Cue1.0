import 'dart:async';

import 'package:cue/video_control/video_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cue/Home/mainPage.dart';
import 'package:cue/login/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => VideoModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LogIn())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.orange, child: Image.asset('images/splash.png'));
  }
}
//Future<void> main() async {
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  var token = prefs.getString('token');
//  print(token);
//  runApp(MaterialApp(home: token == null ? LogIn() : MyHomePage()));
//}