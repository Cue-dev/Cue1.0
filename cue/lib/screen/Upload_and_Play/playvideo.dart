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
                                  'Views ' +
                                      widget.videoToPlay.views.toString(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Likes ' +
                                      widget.videoToPlay.likes.toString(),
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
                          onPressed: () {}),
                    ],
                  ),
                ),
                Divider(),
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
