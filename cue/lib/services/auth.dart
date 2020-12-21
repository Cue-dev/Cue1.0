import 'package:firebase_auth/firebase_auth.dart';
import 'package:cue/services/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserID _userFromFirebaseUser(User user) {
    return user != null ? UserID(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserID> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password

  // register with email and password

  // sign out

}
