import 'dart:async';

import 'package:cue/screen/Cam/camera_alone.dart';
import 'package:cue/screen/Cam/camera_multiplay.dart';
import 'package:cue/services/video.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:screen/screen.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_controls/video_player_controls.dart';

class PlayVideoPage extends StatefulWidget {
  final Video videoToPlay;
  PlayVideoPage({Key key, @required this.videoToPlay}) : super(key: key);

  @override
  _PlayVideoPageState createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  Controller controller;

  // var _disposed = false;
  // var _isFullScreen = false;
  // Timer _timerVisibleControl;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoToPlay.videoURL);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    // Screen.keepOn(true);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();

    controller = new Controller(
      items: [
        PlayerItem(
            title: widget.videoToPlay.title, url: widget.videoToPlay.videoURL),
      ],
      autoPlay: true,
      errorBuilder: (context, message) {
        return new Container(
          child: new Text(message),
        );
      },
      autoInitialize: true,
      hasSubtitles: true,
      showSkipButtons: false,
      allowFullScreen: true,
      fullScreenByDefault: false,
      // placeholder: new Container(
      //   color: Colors.grey,
      // ),
    );
  }

  @override
  void dispose() {
    // _disposed = true;
    // _timerVisibleControl?.cancel();
    // Screen.keepOn(false);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // _exitFullScreen();
    _controller?.pause(); // mute instantly
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  // void _toggleFullscreen() async {
  //   if (_isFullScreen) {
  //     _exitFullScreen();
  //   } else {
  //     _enterFullScreen();
  //   }
  // }

  // void _enterFullScreen() async {
  //   debugPrint("enterFullScreen");
  //   await SystemChrome.setEnabledSystemUIOverlays([]);
  //   await SystemChrome.setPreferredOrientations(
  //       [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  //   if (_disposed) return;
  //   setState(() {
  //     _isFullScreen = true;
  //   });
  // }

  // void _exitFullScreen() async {
  //   debugPrint("exitFullScreen");
  //   await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  //   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //   if (_disposed) return;
  //   setState(() {
  //     _isFullScreen = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                // AspectRatio(
                //   aspectRatio: 16 / 9,
                //   child: Container(
                //     color: Colors.black,
                //     child: SizedBox.expand(
                //       child: FittedBox(
                //         fit: BoxFit.fitHeight,
                //         child: SizedBox(
                //           width: _controller.value.size?.width ?? 0,
                //           height: _controller.value.size?.height ?? 0,
                //           child: VideoPlayer(_controller),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // _isFullScreen
                //     ? Container(
                //         child: Center(child: _playView(context)),
                //         decoration: BoxDecoration(color: Colors.black),
                //       )
                //     : Container(
                //         child: Center(child: _playView(context)),
                //         decoration: BoxDecoration(color: Colors.black),
                //       ),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    child: VideoPlayerControls(
                      controller: controller,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 24,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.orange)),
                          onPressed: () {},
                          color: Colors.orange,
                          textColor: Colors.white,
                          child: Text(widget.videoToPlay.source,
                              style: Theme.of(context).textTheme.subtitle2),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.videoToPlay.tag,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.videoToPlay.title,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text(
                                  '조회 수 ' + widget.videoToPlay.views.toString(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '도전 수 ' + widget.videoToPlay.likes.toString(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          icon: ImageIcon(AssetImage('icons/스크랩.png')),
                          iconSize: 35,
                          onPressed: () {}),
                      IconButton(
                          icon: ImageIcon(AssetImage('icons/큐.png')),
                          iconSize: 35,
                          onPressed: () {
                            setState(() {
                              controller.pause();
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CameraMultiplayPage(
                                          originalVideo: widget.videoToPlay,
                                        )));
                          }),
                    ],
                  ),
                ),
                Divider(),
//                Container(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: [
//                      Text('대본 펼치기'),
//                      SizedBox(width: 200),
//                      IconButton(
//                          icon: Icon(Icons.keyboard_arrow_down),
//                          onPressed: () {}),
//                    ],
//                  ),
//                ),
                showScript(context, widget.videoToPlay.script)
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget showScript(BuildContext context, var script) {
    return Container(
      height: 340,
      width: 400,
      child: ListView.builder(
        itemCount: script.keys.length ~/ 2,
        itemBuilder: (context, int index) {
          String aKey = script.keys.elementAt(index * 2);
          String sKey = script.keys.elementAt(index * 2 + 1);
          return Column(
            children: [
              ListTile(
                leading: Text("${script[aKey]}",
                    style: Theme.of(context).textTheme.bodyText1
                    //.copyWith(fontWeight: FontWeight.bold),
                    ),
                title: Text("${script[sKey].replaceAll('\\n', '\n')}",
                    style: TextStyle(fontSize: 13)),
              )
            ],
          );
        },
      ),
    );
  }
}
