import 'package:flutter/material.dart';

class PVexample extends StatefulWidget {
  @override
  _PVexampleState createState() => _PVexampleState();
}

class _PVexampleState extends State<PVexample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.black,
              // child: SizedBox.expand(
              //   child: FittedBox(
              //     fit: BoxFit.fitHeight,
              //     child: SizedBox(
              //       width: _controller.value.size?.width ?? 0,
              //       height: _controller.value.size?.height ?? 0,
              //       child: VideoPlayer(_controller),
              //     ),
              //   ),
              // ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 105,
                  height: 23,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.orange)),
                    onPressed: () {},
                    color: Colors.orange,
                    textColor: Colors.white,
                    child: Text('뷰티 인사이드',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '#서현진 #사이다연기 #딕션 #분노',
                  style: TextStyle(color: Colors.orange, fontSize: 13),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '딕션맛집 서현진의 속 시원한 탄산 모먼트',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            '조회수 3.9천',
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '도전수 1.4천',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                    icon: ImageIcon(AssetImage('icons/스크랩.png')),
                    onPressed: () {}),
                IconButton(
                    icon: ImageIcon(AssetImage('icons/큐.png')),
                    onPressed: () {}),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
