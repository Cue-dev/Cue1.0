import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cue/Functions/loading.dart';
import 'package:cue/services/database.dart';
import 'package:cue/login/login.dart';

CloudStorageDemoState pageState;

class CloudStorageDemo extends StatefulWidget {
  @override
  CloudStorageDemoState createState() {
    pageState = CloudStorageDemoState();
    return pageState;
  }
}

class CloudStorageDemoState extends State<CloudStorageDemo> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _expController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  File _image;
  String title = '';
  bool public = true;
  bool participation = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: RaisedButton(
                          child: Text("갤러리"),
                          onPressed: () {
                            _uploadVideo(ImageSource.gallery);
                          },
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '제목을 입력하세요!';
                          } else
                            return null;
                        },
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: '제목',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '설명을 입력하세요!';
                          } else
                            return null;
                        },
                        controller: _expController,
                        decoration: InputDecoration(
                          hintText: '설명',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Text('공개'),
                          Switch(
                            value: public,
                            onChanged: (value) {
                              setState(() {
                                public == false
                                    ? public = true
                                    : public = false;
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('참여하기'),
                          Switch(
                            value: participation,
                            onChanged: (value) {
                              setState(() {
                                participation == false
                                    ? participation = true
                                    : participation = false;
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          FlatButton(
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.black,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() {
                                  _loading = true;
                                });
                                _uploadVideo(ImageSource.gallery);
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  void _uploadVideo(ImageSource source) async {
    // final DateTime now = DateTime.now();
    // final String month = now.month.toString();
    // final String date = now.day.toString();
    // final String hour = now.hour.toString();
    // final String minute = now.minute.toString();
    // final String second = now.second.toString();
    // final String uploadTime = ('$month월$date일 $hour:$minute:$second');

    // ignore: deprecated_member_use
    final file = await ImagePicker.pickVideo(source: source);

    if (file == null) return;
    setState(() {
      _image = file;
    });

    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("videos")
        .child('${_titleController.text}:${user.uid}');

    StorageUploadTask uploadTask =
        ref.putFile(file, StorageMetadata(contentType: 'video/mp4'));

    await uploadTask.onComplete;

    String downloadUrl = await ref.getDownloadURL();

    final String url = downloadUrl.toString();

    if (user != null) {
      await DatabaseService(uid: user.uid).createVideoData(
          _titleController.text,
          user.uid,
          _expController.text,
          public,
          participation,
          url);
    }

    setState(() {
      _loading = false;
    });
  }
}
