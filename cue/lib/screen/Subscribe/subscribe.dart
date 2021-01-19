import 'dart:async';

import 'package:cue/screen/Upload_and_Play/playvideo.dart';
import 'package:cue/video_control/video_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cue/video_control/video.dart';

class SubscribePage extends StatefulWidget {
  SubscribePage({Key key}) : super(key: key);

  @override
  _SubscribePageState createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  Stream<List<Video>> listVideos;

  // VideosBloc _videosBloc;

  List<String> videoURLs = List();

  void clearHistory() {
    videoURLs.clear();
  }

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final double mh = MediaQuery
        .of(context)
        .size
        .height;
    final double mw = MediaQuery
        .of(context)
        .size
        .width;
    final videoModel = Provider.of<VideoModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Cue!",
          style: Theme
              .of(context)
              .textTheme
              .headline2,
        ),
        actions: [
          Builder(builder: (context) => // Ensure Scaffold is in context
          IconButton(
            iconSize: 40.0,
            icon: ImageIcon(
              AssetImage('icons/구독.png'),
              color: Colors.black,
            ),
              onPressed: () => Scaffold.of(context).openEndDrawer()
          )),
        ],
      ),
        endDrawer: Drawer(
          elevation: 10.0,
          child: ListView(
            children: <Widget>[
              //고칠 부분
              ListTile( leading: Text('구독 목록', style: TextStyle(fontSize: 20),), trailing: Text('편집',style: TextStyle(fontSize: 12)),),
              Divider(color: Colors.black,thickness: 1,),
              ListTile(
                title: Row(
                      children: [
                        CircleAvatar(radius: 3.0,backgroundColor: Colors.orange,),
                        SizedBox(width:5),
                        CircleAvatar(radius: 20.0,backgroundImage:NetworkImage('https://t1.daumcdn.net/cfile/tistory/240FCE4B529476F337')),
                        SizedBox(width:10),
                        Text('눈물 많은 사람'),
                      ],
                    ),
              ),
              ListTile(
                    title: Row(
                      children: [
                        CircleAvatar(radius: 3.0,backgroundColor: Colors.orange),
                        SizedBox(width:5),
                        CircleAvatar(radius: 20.0,backgroundImage:NetworkImage('https://image.chosun.com/sitedata/image/201402/04/2014020402439_0.jpg')),
                        SizedBox(width:10),
                        Text('풀림'),
                      ],
                    ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12,8,8,8),
                child: ListTile( title: Text('녜정'), leading: CircleAvatar(radius: 20.0,backgroundImage:NetworkImage('https://img2.sbs.co.kr/img/sbs_cms/CH/2017/04/28/CH33108141_w666_h968.jpg')) ),
              ),
              ListTile(
                title: Row(
                  children: [
                    CircleAvatar(radius: 3.0,backgroundColor: Colors.orange),
                    SizedBox(width:5),
                    CircleAvatar(radius: 20.0,backgroundImage:NetworkImage('https://img.asiatoday.co.kr/file/2017y/02m/13d/20170213001540464_1486977113_1.jpeg')),
                    SizedBox(width:10),
                    Text('김배우'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12,8,8,8),
                child: ListTile( title: Text('박연'), leading: CircleAvatar(radius: 20.0,backgroundImage:NetworkImage('https://imgbntnews.hankyung.com/bntdata/images/photo/201611/c8b44cd010b75655bcad8a6a98ec1cdf.jpg')) ),
              ),

            ],
          ),
        ),
      body:
      FutureBuilder(
          future: videoModel.loadVideos(),
          builder: (context, AsyncSnapshot<List<Video>> snapshot) {
            return snapshot.hasData
                ? ListView.separated(
              separatorBuilder: (context, index) => SizedBox(),
              padding: EdgeInsets.fromLTRB(
                  mw * 0.02, mh * 0.01, mw * 0.02, mh * 0.01),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                print(snapshot.data.length);
                return InkWell(
                  child: Container(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: mh * 0.3,
                                width: mw,
                                child: Image.network(
                                    'https://i.ytimg.com/vi/UwkWHunhbtI/maxresdefault.jpg'),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(left: mw * 0.02, bottom: mh * 0.02),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text('[국가부도의 날] 유아인 독백연기 도전',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .subtitle1),
                                      SizedBox(height: 3),
                                      Text(
                                        '#유아인 #독백연기 #서울예대 #배우지망생',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .caption,
                                      ),
                                      SizedBox(height: mh * 0.01),
                                      Row(
                                        children: [
                                          Text('김배우'),
                                          SizedBox(width: mw * 0.04),
                                          Text('조회수 2.3천'),
                                          SizedBox(width: mw * 0.04),
                                          Text('3일 전'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        iconSize: 30.0,
                                        icon: ImageIcon(
                                            AssetImage('icons/좋아요.png')),
                                        onPressed: () {}),
                                    Text('1231', style: TextStyle(fontSize: 10))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PlayVideoPage(
                                  videoToPlay:
                                  snapshot.data[index],
                                )));
                  },
                );
              },
            )
                : Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}