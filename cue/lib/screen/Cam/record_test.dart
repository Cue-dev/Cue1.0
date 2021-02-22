//import 'dart:async';
//import 'dart:io';
//import 'package:flutter/material.dart';
//import 'package:flutter_sound/flutter_sound.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//
//typedef _Fn = void Function();
//
///// Example app.
//class SimpleRecorder extends StatefulWidget {
//  @override
//  _SimpleRecorderState createState() => _SimpleRecorderState();
//}
//
//class _SimpleRecorderState extends State<SimpleRecorder> {
////  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
//  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
////  bool _mPlayerIsInited = false;
//  bool _mRecorderIsInited = false;
////  bool _mplaybackReady = false;
//  String _mPath;
//
//  @override
//  void initState() {
//    // Be careful : openAudioSession return a Future.
//    // Do not access your FlutterSoundPlayer or FlutterSoundRecorder before the completion of the Future
////    _mPlayer.openAudioSession().then((value) {
////      setState(() {
////        _mPlayerIsInited = true;
////      });
////    });
//    openTheRecorder().then((value) {
//      setState(() {
//        _mRecorderIsInited = true;
//      });
//    });
//    super.initState();
//  }
//
//  @override
//  void dispose() {
////    stopPlayer();
////    _mPlayer.closeAudioSession();
////    _mPlayer = null;
//
//    stopRecorder();
//    _mRecorder.closeAudioSession();
//    _mRecorder = null;
//    if (_mPath != null) {
//      var outputFile = File(_mPath);
//      if (outputFile.existsSync()) {
//        outputFile.delete();
//      }
//    }
//    super.dispose();
//  }
//
//  Future<void> openTheRecorder() async {
//    var status = await Permission.microphone.request();
//    if (status != PermissionStatus.granted) {
//      throw RecordingPermissionException('Microphone permission not granted');
//    }
//
//    var tempDir = await getTemporaryDirectory();
//    _mPath = '${tempDir.path}/flutter_sound_example.aac';
//    var outputFile = File(_mPath);
//    if (outputFile.existsSync()) {
//      await outputFile.delete();
//    }
//    await _mRecorder.openAudioSession();
//    _mRecorderIsInited = true;
//  }
//
//  // ----------------------  Here is the code for recording and playback -------
//
//  Future<void> record() async {
//    assert(_mRecorderIsInited );//&& _mPlayer.isStopped);
//    await _mRecorder.startRecorder(
//      toFile: _mPath,
//      codec: Codec.aacADTS,
//    );
//    setState(() {});
//  }
//
//  Future<void> stopRecorder() async {
//    await _mRecorder.stopRecorder();
//    addUser();
////    _mplaybackReady = true;
//  }
//  Future<void> addUser() async {
//    firebase_storage.StorageReference ref = firebase_storage
//        .FirebaseStorage.instance
//        .ref()
//        .child("product")
//        .child('record');
//
//    firebase_storage.StorageUploadTask uploadTask =
//    ref.putFile(File(_mPath));
//    String downloadUrl = await ref.getDownloadURL();
//    final String url = downloadUrl.toString();
////    videoRecordurl = url;
//    print('recordurl: ' + url);
//  }
//
////  void play() async {
////    assert(_mPlayerIsInited &&
////        _mplaybackReady &&
////        _mRecorder.isStopped &&
////        _mPlayer.isStopped);
////    await _mPlayer.startPlayer(
////        fromURI: _mPath,
////        codec: Codec.aacADTS,
////        whenFinished: () {
////          setState(() {});
////        });
////    setState(() {});
////  }
////
////  Future<void> stopPlayer() async {
////    await _mPlayer.stopPlayer();
////  }
//
//// ----------------------------- UI --------------------------------------------
//
//  _Fn getRecorderFn() {
//    if (!_mRecorderIsInited){// || !_mPlayer.isStopped) {
//      return null;
//    }
//    return _mRecorder.isStopped
//        ? record
//        : () {
//      stopRecorder().then((value) => setState(() {}));
//    };
//  }
//
////  _Fn getPlaybackFn() {
////    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder.isStopped) {
////      return null;
////    }
////    return _mPlayer.isStopped
////        ? play
////        : () {
////      stopPlayer().then((value) => setState(() {}));
////    };
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    Widget makeBody() {
//      return
////        Column(
////        children: [
////          Container(
////            margin: const EdgeInsets.all(3),
////            padding: const EdgeInsets.all(3),
////            height: 80,
////            width: double.infinity,
////            alignment: Alignment.center,
////            decoration: BoxDecoration(
////              color: Color(0xFFFAF0E6),
////              border: Border.all(
////                color: Colors.indigo,
////                width: 3,
////              ),
////            ),
////            child:
//      Row(children: [
//              RaisedButton(
//                onPressed: getRecorderFn(),
//                color: Colors.white,
//                disabledColor: Colors.grey,
//                child: Text(_mRecorder.isRecording ? 'Stop' : 'Record'),
//              ),
//              SizedBox(
//                width: 20,
//              ),
//              Text(_mRecorder.isRecording
//                  ? 'Recording in progress'
//                  : 'Recorder is stopped'),
//            ]
////      ),
////          ),
////          Container(
////            margin: const EdgeInsets.all(3),
////            padding: const EdgeInsets.all(3),
////            height: 80,
////            width: double.infinity,
////            alignment: Alignment.center,
////            decoration: BoxDecoration(
////              color: Color(0xFFFAF0E6),
////              border: Border.all(
////                color: Colors.indigo,
////                width: 3,
////              ),
////            ),
////            child: Row(children: [
////              RaisedButton(
////                onPressed: getPlaybackFn(),
////                color: Colors.white,
////                disabledColor: Colors.grey,
////                child: Text(_mPlayer.isPlaying ? 'Stop' : 'Play'),
////              ),
////              SizedBox(
////                width: 20,
////              ),
////              Text(_mPlayer.isPlaying
////                  ? 'Playback in progress'
////                  : 'Player is stopped'),
////            ]),
////          ),
////        ],
//      );
//    }
//
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Simple Recorder'),
//      ),
//      body: makeBody(),
//    );
//  }
//}
