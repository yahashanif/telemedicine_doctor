import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoFullPage extends StatefulWidget {
  final String url;

  const VideoFullPage({super.key, required this.url});

  @override
  _VideoFullPageState createState() => _VideoFullPageState();
}

class _VideoFullPageState extends State<VideoFullPage> {
  late VideoPlayerController _controller;
  bool _isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
          _isLoading = false;
          _controller.play();
          isError = false;
        });
      }).catchError((error) {
        setState(() {
          _isLoading = false;
          isError = true;
        });
        // Handle error (e.g., show error message)
        print('Error initializing video: $error');
      });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        Navigator.pop(context);
        return false;
      },
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Center(
                child: _isLoading
                    ? CircularProgressIndicator() // Show loading indicator while video is loading
                    : AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: InkWell(
                            onTap: () {
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                                setState(() {});
                              }
                            },
                            child: VideoPlayer(_controller)),
                      ),
              ),
              Positioned(
                top: 25,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                    ]);
                    _controller.pause();
                    Navigator.pop(context);
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    if (isError) {
                      _controller = VideoPlayerController.network(widget.url)
                        ..initialize().then((_) {
                          setState(() {
                            _isLoading = false;
                            _controller.play();
                            isError = false;
                          });
                        }).catchError((error) {
                          setState(() {
                            _isLoading = false;
                            isError = true;
                          });
                          // Handle error (e.g., show error message)
                          print('Error initializing video: $error');
                        });
                    }
                    print(widget.url);
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                    setState(() {});
                  },
                  child: _controller.value.isPlaying
                      ? SizedBox()
                      : Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: isError
                              ? Icon(Icons.error)
                              : Icon(_controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
