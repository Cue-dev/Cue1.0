import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cue/Functions/loading.dart';
import 'package:video_player/video_player.dart';
import 'package:cue/video_control/video.dart';
import 'package:cue/video_control/video_bloc.dart';
import 'package:cue/video_control/video_api.dart';

class PlayPage extends StatefulWidget {
  PlayPage({Key key}) : super(key: key);

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  Stream<List<Video>> listVideos;
  VideosBloc _videosBloc;

  List<String> videoURLs = List();
  void clearHistory() {
    videoURLs.clear();
  }

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    clearHistory();

    setState(() {
      _loading = true;
    });
    _videosBloc = VideosBloc(VideosAPI());
    listVideos = _videosBloc.listVideos;

    if (listVideos != null) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                "Voing",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Rochester',
                  letterSpacing: 3.0,
                ),
              ),
            ),
            body: Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  middleSection,
                ],
              ),
            ]),
          );
  }

  Widget get middleSection => Expanded(child: videoViewer());

  Widget videoViewer() {
    return Container(
        child: Center(
            child: StreamBuilder(
                initialData: List<Video>(),
                stream: listVideos,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    List<Video> videos = snapshot.data;
                    if (videos.length > 0) {
                      print(
                          '||||||||||||||||||||||||||length : ${videos.length}');
                      return PageView.builder(
                        controller: PageController(
                          initialPage: 0,
                          viewportFraction: 1,
                        ),
                        onPageChanged: (index) {
                          index = index % (videos.length);
                          _videosBloc.videoManager.changeVideo(index);
                        },
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          index = index % (videos.length);
                          return videoCard(
                              _videosBloc.videoManager.listVideos[index]);
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
                })));
  }

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
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[],
            ),
            SizedBox(height: 65)
          ],
        )
      ],
    );
  }
}
