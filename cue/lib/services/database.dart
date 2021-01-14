import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cue/screen/login/login.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference videoCollection =
      FirebaseFirestore.instance.collection('videos');

  Future createUserData(String nickName) async {
    return await userCollection.doc(uid).set({
      'name': nickName,
      'follwing': 0,
      'follower': 0,
    });
  }

  Future createVideoData(String title, String uploader, String explanation,
      bool public, bool participation, String url) async {
    return await videoCollection.doc('$title:${user.uid}').set({
      'title': title,
      'uploader': uploader,
      'explanation': explanation,
      'public': public,
      'participation': participation,
      'like': 0,
      'url': url,
    });
  }
}

Future getVideoSnapshots() async {
  return FirebaseFirestore.instance.collection('videos').get();
}
