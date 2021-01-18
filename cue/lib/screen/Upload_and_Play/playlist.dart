import 'dart:async';

import 'package:cue/screen/Upload_and_Play/playvideo.dart';
import 'package:cue/video_control/video_provider.dart';
import 'package:flutter/material.dart';
import 'package:cue/Functions/loading.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:cue/video_control/video.dart';
// import 'package:cue/video_control/video_bloc.dart';
// import 'package:cue/video_control/video_api.dart';

class PlayListPage extends StatefulWidget {
  PlayListPage({Key key}) : super(key: key);

  @override
  _PlayListPageState createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  Stream<List<Video>> listVideos;
  // VideosBloc _videosBloc;

  List<String> videoURLs = List();
  void clearHistory() {
    videoURLs.clear();
  }

  bool _loading = false;

  // @override
  // void initState() {
  //   super.initState();
  //   clearHistory();

  //   setState(() {
  //     _loading = true;
  //   });
  //   _videosBloc = VideosBloc(VideosAPI());
  //   listVideos = _videosBloc.listVideos;

  //   if (listVideos != null) {
  //     setState(() {
  //       _loading = false;
  //     });
  //   }
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final double mh = MediaQuery.of(context).size.height;
    final double mw = MediaQuery.of(context).size.width;
    final videoModel = Provider.of<VideoModel>(context, listen: false);

    return _loading
        ? Loading()
        : DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0.0,
                  title: Text(
                    "Cue!",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  bottom: TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.grey,
                    tabs: [
                      Tab(text: '추천 인기'),
                      Tab(text: '인기 도전'),
                    ],
                  ),
                ),
                body: TabBarView(children: <Widget>[
                  // middleSection,
                  FutureBuilder(
                      future: videoModel.loadVideos(),
                      builder: (context, AsyncSnapshot<List<Video>> snapshot) {
                        return snapshot.hasData
                            ? ListView.separated(
                                separatorBuilder: (context, index) => Divider(),
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
                                              child: snapshot.data[index]
                                                          .thumbnailURL !=
                                                      null
                                                  ? Image.network(
                                                      snapshot.data[index]
                                                          .thumbnailURL,
                                                      fit: BoxFit.fitWidth,
                                                    )
                                                  : Container(
                                                      color: Colors.black),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Container(
                                                width: 120,
                                                height: 22,
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                      snapshot
                                                          .data[index].source,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: mw * 0.02),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        snapshot
                                                            .data[index].title,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1),
                                                    SizedBox(height: 3),
                                                    Text(
                                                      snapshot.data[index].tag,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  iconSize: 70.0,
                                                  icon: ImageIcon(
                                                    AssetImage('icons/스크랩.png'),
                                                  ),
                                                  onPressed: () {}),
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
                  Container()
                ])),
          );
  }

//  Widget get middleSection => Expanded(child: videoViewer());
//
//  Widget videoViewer() {
//    // return ListView(
//    //     children:
//    //         Provider.of<VideoModel>(context, listen: false).videos.map((video) {
//    //   print(video.title);
//    //   return ListTile(leading: Text(video.title));
//    // }).toList());
//
//    // return Column(
//    //   children: [
//    //     builder: ,)
//    //   ],
//    // );
//
//    // return Container(
//    //     child: Center(
//    //         child: StreamBuilder(
//    //             initialData: List<Video>(),
//    //             stream: listVideos,
//    //             builder: (BuildContext context, AsyncSnapshot snapshot) {
//    //               if (!snapshot.hasData) {
//    //                 return CircularProgressIndicator();
//    //               } else {
//    //                 List<Video> videos = snapshot.data;
//    //                 if (videos.length > 0) {
//    //                   print(
//    //                       '||||||||||||||||||||||||||length : ${videos.length}');
//    //                   return PageView.builder(
//    //                     controller: PageController(
//    //                       initialPage: 0,
//    //                       viewportFraction: 1,
//    //                     ),
//    //                     onPageChanged: (index) {
//    //                       index = index % (videos.length);
//    //                       _videosBloc.videoManager.changeVideo(index);
//    //                     },
//    //                     scrollDirection: Axis.vertical,
//    //                     itemBuilder: (context, index) {
//    //                       index = index % (videos.length);
//    //                       return videoCard(
//    //                           _videosBloc.videoManager.listVideos[index]);
//    //                     },
//    //                   );
//    //                 } else {
//    //                   return CircularProgressIndicator();
//    //                 }
//    //               }
//    //             })));
//  }

  Widget videoCard(Video video) {
    var controller = video.controller;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        controller != null && controller.value.initialized
            ? GestureDetector(
                onTap: () {
                  controller.value.isPlaying
                      ? controller.pause()
                      : controller.play();
                },
                child: SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.size?.width ?? 0,
                    height: controller.value.size?.height ?? 0,
                    child: VideoPlayer(controller),
                  ),
                )))
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 56,
                  )
                ],
              ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: <Widget>[
        //     Row(
        //       mainAxisSize: MainAxisSize.max,
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: <Widget>[],
        //     ),
        //     SizedBox(height: 65)
        //   ],
        // )
      ],
    );
  }
}
