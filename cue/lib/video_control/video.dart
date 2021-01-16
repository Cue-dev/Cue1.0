import 'package:video_player/video_player.dart';

class Video {
  String title;
  String explanation;
  int likes;
  int views;
  String uploader;
  String videoURL;
  String script;
  String thumbnailURL;

  VideoPlayerController controller;

  Video(
      {this.title,
      this.explanation,
      this.likes,
      this.views,
      this.uploader,
      this.videoURL,
      this.script,
      this.thumbnailURL});

  Video.getFromDB(var value, int i) {
    title = value.documents[i].data['title'];
    explanation = value.documents[i].data['explanation'];
    likes = value.documents[i].data['likes'];
    views = value.documents[i].data['views'];
    uploader = value.documents[i].data['uploader'];
    videoURL = value.documents[i].data['videoURL'];
    script = value.documents[i].data['script'];
    thumbnailURL = value.documents[i].data['thumbnailURL'];
  }

  setupVideo() {
    controller = VideoPlayerController.network(videoURL)
      ..initialize().then((_) {
        controller.setLooping(true);
      });
  }
}
