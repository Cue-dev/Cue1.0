import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cue/video_control/video.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoModel extends ChangeNotifier {
  final List<Video> _videos = [];

  // VideoModel() {
  //   loadVideos();
  // }

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
            like: doc.data()['like'],
            public: doc.data()['public'],
            participation: doc.data()['participation'],
            uploader: doc.data()['uploader'],
            videoURL: doc.data()['videoURL']);
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
