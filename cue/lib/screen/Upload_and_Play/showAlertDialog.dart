import 'package:flutter/material.dart';

class CheckboxesDemo extends StatefulWidget {
  @override
  _CheckboxesDemoState createState() => _CheckboxesDemoState();
}

class _CheckboxesDemoState extends State<CheckboxesDemo> {
  List<bool> checked= [false,false,false,false,false,false];
  List<String> scraplist = [
    '좋아하는 영화 명대사',
    '딕션 연습',
    '눈물 연기 연습',
    '분노 연기 연습'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkboxes Demo'),
        backgroundColor: Color(0xFF6200EE),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            for (var i = 0; i < 4; i += 1)
              Row(
                children: [
                  Checkbox(
                    onChanged: (bool value) {
                      setState(() {
                        checked[i] = value;
                      });
                    },

                    value: checked[i],
                    activeColor: Color(0xFF6200EE),
                  ),
                  Text(
                    scraplist[i],

                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
          ],
        ),
      ),
    );
  }
}
