//import 'dart:async';
////import 'dart:io';
//import 'package:flutter/material.dart';
//import 'package:flutter_sound/flutter_sound.dart';
////import 'package:path_provider/path_provider.dart';
////import 'package:permission_handler/permission_handler.dart';
////import 'package:firebase_core/firebase_core.dart';
////import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//import 'package:audioplayers/audioplayers.dart';
//
//class SimpleUpload extends StatefulWidget {
//  @override
//  _SimpleUploadState createState() => _SimpleUploadState();
//}
//
//class _SimpleUploadState extends State<SimpleUpload> {
//  AudioPlayer player = AudioPlayer();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Simple Recorder'),
//      ),
//      body:
//        MaterialButton(
//          child: Text("click"),
//          onPressed: (){
//            _incrementCounter();
//          },
//        )
//    );
//  }
//
//  _incrementCounter() async{
//    const _mPath = "https://firebasestorage.googleapis.com/v0/b/cue-f7a5d.appspot.com/o/product%2Fcelebrity.mp3?alt=media&token=460e4c47-053c-4ad7-9820-f3d91f85f945";
//    player.play(_mPath);
//  }
//}
