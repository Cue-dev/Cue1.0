import 'package:cue/app.dart';
import 'package:cue/services/user_provider.dart';
import 'package:cue/services/video_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => VideoModel()),
    ChangeNotifierProvider<FirebaseAuthService>(
        create: (context) => FirebaseAuthService())
  ], child: CueApp()));
}
