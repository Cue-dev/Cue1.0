import 'package:cue/video_control/video_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayVideoPage extends StatefulWidget {
  @override
  _PlayVideoPageState createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return Column(
              children: [
                AspectRatio(
                    // aspectRatio: _controller.value.aspectRatio,
                    aspectRatio: 16 / 9,
                    // Use the VideoPlayer widget to display the video.
                    // child: VideoPlayer(_controller),
                    child: Container(
                      color: Colors.black,
                      child: SizedBox.expand(
                          child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: SizedBox(
                          width: _controller.value.size?.width ?? 0,
                          height: _controller.value.size?.height ?? 0,
                          child: VideoPlayer(_controller),
                        ),
                      )),
                    )),
              ],
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
