import 'package:flutter/material.dart';
import 'package:tvent/app/modules/about/controllers/about_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late AboutController _aboutController;

  bool _isBuffering = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(_videoPlayerListener);

    _initializeVideoPlayerFuture = _initializeVideoPlayer();

    _aboutController = Get.find<AboutController>();
  }

  Future<void> _initializeVideoPlayer() async {
    await _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(0.0);
    // _videoPlayerListener();
  }

  void _videoPlayerListener() {
    if (_aboutController.videoEnabled.value &&
        !_controller.value.isPlaying &&
        !_isBuffering) {
      // Mulai pemutaran video jika diizinkan
      _controller.play();
    }

    if (!_controller.value.isBuffering && _isBuffering) {
      // Video tidak lagi buffering
      setState(() {
        _isBuffering = false;
      });
    } else if (_controller.value.isBuffering && !_isBuffering) {
      // Video sedang buffering
      setState(() {
        _isBuffering = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildVideoPlayerWidget();
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildVideoPlayerWidget() {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(_controller),
              if (_isBuffering)
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 243, 180, 33),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      height: _controller.value.aspectRatio,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color.fromARGB(255, 243, 180, 33),
          ),
        ),
      ),
    );
  }
}
