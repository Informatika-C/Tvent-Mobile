import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AboutController extends GetxController {
   late VideoPlayerController videoController;

  final String videoUrl = "https://tvent.azurewebsites.net/assets/images/lv_0_20231108111358.mp4";

  @override
  void onInit() {
    super.onInit();
    videoController = VideoPlayerController.network(videoUrl);
    videoController.initialize().then((_) {
      videoController.setLooping(true); 
      videoController.setVolume(0.0); 
      update(); 
    });
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
