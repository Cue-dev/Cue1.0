import 'dart:async';

import 'package:cue/video_control/video.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoToPlay.videoURL);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.black,
                    child: SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: SizedBox(
                          width: _controller.value.size?.width ?? 0,
                          height: _controller.value.size?.height ?? 0,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text('부당거래'),
                    Text('#부당거래 #류승범 #호의 #둘리'),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(widget.videoToPlay.title),
                          Row(
                            children: [
                              Text(
                                  '조회수 ' + widget.videoToPlay.views.toString()),
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
                Divider(),
                // Text(widget.videoToPlay.script),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
