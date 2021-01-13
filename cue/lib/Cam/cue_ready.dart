import 'package:cue/Cam/camera_example.dart';
import 'package:flutter/material.dart';

class CueReady extends StatefulWidget {
  @override
  _CueReadyState createState() => _CueReadyState();
}

class _CueReadyState extends State<CueReady> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: FlatButton(
              child: Text('Cue!'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            VideoRecorderExample()));
              },
            )
        )
    );
  }
}
