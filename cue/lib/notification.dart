import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> notification = [
    '풀림 님이 [국가부도의 날] 2020.11.30 유아인 연기 도전을 좋아합니다.',
    '배우자 님이 [커피프린스 1호점] 윤은혜 눈물 을 좋아합니다.',
    '[커피프린스 1호점]  윤밴 님 외에 941명이 좋아합니다.',
    'Tan 님이 회원님을 구독하였습니다.',
    '마은솔 님이 회원님을 구독하였습니다.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        title: Text("Cue!",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body:  ListView.separated(
        itemCount: notification.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: (index == 0||index == 1||index == 2)?CircleAvatar(radius: 5.0,backgroundColor: Colors.yellow,):CircleAvatar(radius: 5.0,backgroundColor: Colors.orange,),
                ),
                Container(
                    width: MediaQuery.of(context).size.width *0.7,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                        child: Text(notification[index]),
                )),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox();
        },)
    );
  }
}
