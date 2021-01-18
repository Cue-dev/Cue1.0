import 'package:video_player/video_player.dart';

class Video {
  String title;
  String explanation;
  int likes;
  int views;
  String uploader;
  String videoURL;
  String thumbnailURL;
  String headline;
  String tag;

  VideoPlayerController controller;

  Video(
      {this.title,
      this.explanation,
      this.likes,
      this.views,
      this.uploader,
      this.videoURL,
      this.thumbnailURL,
      this.headline,
      this.tag});

  Video.getFromDB(var value, int i) {
    title = value.documents[i].data['title'];
    explanation = value.documents[i].data['explanation'];
    likes = value.documents[i].data['likes'];
    views = value.documents[i].data['views'];
    uploader = value.documents[i].data['uploader'];
    videoURL = value.documents[i].data['videoURL'];
    thumbnailURL = value.documents[i].data['thumbnailURL'];
    headline = value.documents[i].data['headline'];
    tag = value.documents[i].data['tag'];
  }

  setupVideo() {
    controller = VideoPlayerController.network(videoURL)
      ..initialize().then((_) {
        controller.setLooping(true);
      });
  }
}
