import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cue/video_control/video.dart';
import 'package:flutter/material.dart';

class VideoModel extends ChangeNotifier {
  final List<Video> _videos = [];

  List<Video> get videoList => _videos;

  Future<List<Video>> loadVideos() async {
    _videos.clear();

    await FirebaseFirestore.instance
        .collection('videos')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Video video = Video(
            title: doc.data()['title'],
            explanation: doc.data()['explanation'],
            likes: doc.data()['likes'],
            views: doc.data()['views'],
            uploader: doc.data()['uploader'],
            videoURL: doc.data()['videoURL'],
            thumbnailURL: doc.data()['thumbnailURL']);
        add(video);
      });
    });
    return _videos;
  }

  void add(Video video) {
    _videos.add(video);
    notifyListeners();
  }

  void removeAll() {
    _videos.clear();
    notifyListeners();
  }
}
