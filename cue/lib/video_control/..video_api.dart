// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cue/services/database.dart';
// import 'package:cue/video_control/video.dart';

// class VideosAPI {
//   VideosAPI();

//   Future<List<Video>> getVideoList() async {
//     var videoList = <Video>[];

//     getVideoSnapshots().then((value) {
//       // var videoList = <Video>[];

//       if (value.documents.length > 0) {
//         for (int i = 0; i < value.documents.length; i++) {
//           Video video = Video.getFromDB(value, i);
//           videoList.add(video);
//           // manager.listVideos = videoList;
//         }
//       }
//     });
//     return videoList;
//   }

//   //Working in User System
//   Future<bool> removeVideosFromFeed(
//       String userId, List<String> videoIds) async {
//     await FirebaseFirestore.instance
//         .collection('Users')
//         .doc(userId)
//         .update({"videosViewed": FieldValue.arrayUnion(videoIds)});
//     return true;
//   }

//   Future<bool> clearHistory(String userId) async {
//     var user =
//         await FirebaseFirestore.instance.collection('Users').doc(userId).get();
//     var listToRemove = user.get('videosViewed');
//     await FirebaseFirestore.instance
//         .collection('Users')
//         .doc(userId)
//         .update({"videosViewed": FieldValue.arrayRemove(listToRemove)});
//     return true;
//   }
// }
