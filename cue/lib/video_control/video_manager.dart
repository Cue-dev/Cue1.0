import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cue/screen/Upload_and_Play/playlist.dart';
import 'package:cue/video_control/video.dart';

class VideoManager {
  State<PlayListPage> state;
  Function updateController;

  List<Video> listVideos;
  var prevPage = 0;

  Sink<List<Video>> stream;

  VideoManager({this.stream});

  changeVideo(index) async {
    int prev = index > prevPage ? index - 2 : index + 2;
    listVideos[prevPage].controller.pause();
    prevPage = index;

    disposeVideo(prev);
    await loadVideo(index);
    listVideos[index].controller.play();
    stream.add(listVideos);
  }

  Video getVideo(index) {
    return listVideos[index];
  }

  VideoPlayerController getController(index) {
    return listVideos[index].controller;
  }

  playVideo(index) {
    if (listVideos[index].controller != null) {
      listVideos[index].controller.play();
    }
  }

  pauseVideo(index) {
    if (listVideos[index].controller != null) {
      listVideos[index].controller.pause();
    }
  }

  loadVideo(index) async {
    if (listVideos[index].controller == null) {
      listVideos[index].controller =
          await createController(listVideos[index].videoURL);
      stream.add(listVideos);
    }
  }

  disposeVideo(index) {
    if (index >= 0) {
      if (listVideos[index].controller != null) {
        listVideos[index].controller.dispose();
        listVideos[index].controller = null;
      }
    }
  }

  Future<VideoPlayerController> createController(videoURL) async {
    VideoPlayerController controller = VideoPlayerController.network(videoURL);
    await controller.initialize();
    controller.setLooping(true);
    return controller;
  }

  bool hasVideos() {
    if (listVideos.length > 0) return true;
    return false;
  }

  int numOfVideos() {
    return listVideos.length;
  }

  dispose() {
    listVideos.forEach((element) {
      if (element.controller != null) {
        element.controller.dispose();
      }
    });
  }
}
