import 'package:video_player/video_player.dart';

class Video {
  String title;
  String explanation;
  int like;
  bool public;
  bool participation;
  String uploader;
  String videoURL;

  VideoPlayerController controller;

  Video(
      {this.title,
      this.explanation,
      this.like,
      this.public,
      this.participation,
      this.uploader,
      this.videoURL});

  Video.getFromDB(var value, int i) {
    title = value.documents[i].data['title'];
    explanation = value.documents[i].data['explanation'];
    like = value.documents[i].data['like'];
    public = value.documents[i].data['public'];
    participation = value.documents[i].data['participation'];
    uploader = value.documents[i].data['uploader'];
    videoURL = value.documents[i].data['url'];
  }

  // Video.fromJson(Map<dynamic, dynamic> json) {
  //   id = json['id'];
  //   user = json['user'];
  //   userPic = json['user_pic'];
  //   videoTitle = json['video_title'];
  //   songName = json['song_name'];
  //   likes = json['likes'];
  //   comments = json['comments'];
  //   url = json['url'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['user'] = this.user;
  //   data['user_pic'] = this.userPic;
  //   data['video_title'] = this.videoTitle;
  //   data['song_name'] = this.songName;
  //   data['likes'] = this.likes;
  //   data['comments'] = this.comments;
  //   data['url'] = this.url;
  //   return data;
  // }

  setupVideo() {
    controller = VideoPlayerController.network(videoURL)
      ..initialize().then((_) {
        controller.setLooping(true);
      });
  }
}
