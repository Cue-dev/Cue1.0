import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cue/video_control/video_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cue/services/database.dart';
import 'package:cue/video_control/video_api.dart';
import 'package:cue/video_control/video.dart';
import 'package:cue/video_control/video_manager.dart';

class VideosBloc {
  final VideosAPI _videosAPI;
  VideoManager videoManager;
  bool _loading = false;

  VideosBloc(this._videosAPI) {
    videoManager = VideoManager(stream: this.listVideosEvent);
    // Future<List<Video>> futureList = _videosAPI.getVideoList();
    // futureList.then((value) {
    //   if (value != null)
    //     value.forEach((item) => videoManager.listVideos.add(item));
    // });
    loadVideos();
    // print('videoManager.listVideos.length:  ${videoManager.listVideos.length}');
  }

  final BehaviorSubject<List<Video>> _listVideosController =
      new BehaviorSubject<List<Video>>.seeded(List<Video>());

  Stream<List<Video>> get listVideos => _listVideosController.stream;

  Sink<List<Video>> get listVideosEvent => _listVideosController.sink;

  List<Video> get videoList => videoManager.listVideos;

  loadVideos() async {
    // videoManager.listVideos = await _videosAPI.getVideoList();
    // _videosAPI.getVideoList(videoManager);

    await FirebaseFirestore.instance
        .collection('videos')
        .get()
        .then((QuerySnapshot querySnapshot) {
      var videoList = <Video>[];
      VideoModel vm = VideoModel();

// this.title,
//       this.explanation,
//       this.like,
//       this.public,
//       this.participation,
//       this.uploader,
//       this.videoURL
      querySnapshot.docs.forEach((doc) {
        Video video = Video(
            title: doc.data()['title'],
            explanation: doc.data()['explanation'],
            like: doc.data()['like'],
            public: doc.data()['public'],
            participation: doc.data()['participation'],
            uploader: doc.data()['uploader'],
            videoURL: doc.data()['videoURL']);
        // videoList.add(video);
        vm.add(video);
      });

      videoManager.listVideos = videoList;

      // if (value.documents.length > 0) {
      //   for (int i = 0; i < value.documents.length; i++) {
      //     Video video = Video.getFromDB(value, 0);
      //     videoList.add(video);
      //     videoManager.listVideos = videoList;
      //   }
      // }
    });

    if (videoManager.listVideos.length > 0) {
      await videoManager.loadVideo(0);
      videoManager.playVideo(0);
    }
    //listVideosEvent.add(_videoList);
  }
}
