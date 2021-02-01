import 'package:cue/app.dart';
import 'package:cue/services/auth_provider.dart';
import 'package:cue/services/video_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => VideoModel()),
    Provider<AuthProvider>(
      create: (_) => AuthProvider(FirebaseAuth.instance),
    ),
    StreamProvider(
      create: (context) => context.read<AuthProvider>().authState,
    )
    // ChangeNotifierProvider<FirebaseAuthService>(
    //     create: (context) => FirebaseAuthService())
  ], child: CueApp()));
}
