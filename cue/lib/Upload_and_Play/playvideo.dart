import 'package:cue/video_control/video_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayVideoPage extends StatefulWidget {
  @override
  _PlayVideoPageState createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {
  @override
  Widget build(BuildContext context) {
    final videoModel = Provider.of<VideoModel>(context, listen: false);
    return Column(children: [Text(videoModel.videoList[0].title)]);
  }
}
