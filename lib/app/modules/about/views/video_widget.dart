// video_player_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/about/controllers/about_controller.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final AboutController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AspectRatio(
      aspectRatio: controller.videoController.value.aspectRatio,
      child: VideoPlayer(controller.videoController),
    ));
  }
}
