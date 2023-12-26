import 'package:get/get.dart';

class AboutController extends GetxController {
  RxBool videoEnabled = false.obs;

  void enableVideo() {
    videoEnabled.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    enableVideo();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
