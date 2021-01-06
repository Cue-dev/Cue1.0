import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('알림',
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rochester',
            fontSize: 20,
            letterSpacing: 3.0,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
