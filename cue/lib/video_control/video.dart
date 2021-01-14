import 'package:video_player/video_player.dart';

class Video {
  String title;
  String explanation;
  int like;
  bool public;
  bool participation;
  String uploader;
  String videoURL;
  String script;

  VideoPlayerController controller;

  Video(
      {this.title,
      this.explanation,
      this.like,
      this.public,
      this.participation,
      this.uploader,
      this.videoURL,
      this.script});

  Video.getFromDB(var value, int i) {
    title = value.documents[i].data['title'];
    explanation = value.documents[i].data['explanation'];
    like = value.documents[i].data['like'];
    public = value.documents[i].data['public'];
    participation = value.documents[i].data['participation'];
    uploader = value.documents[i].data['uploader'];
    videoURL = value.documents[i].data['videoURL'];
    script = value.documents[i].data['script'];
  }

  setupVideo() {
    controller = VideoPlayerController.network(videoURL)
      ..initialize().then((_) {
        controller.setLooping(true);
      });
  }
}
