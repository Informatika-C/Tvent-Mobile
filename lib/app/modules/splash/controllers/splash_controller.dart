import 'package:get/get.dart';

class SplashController extends GetxController {
  var isInitialized = false.obs;

  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 3));

    isInitialized.value = true;
  }

  final count = 0.obs;
  @override
  void onInit() {
    initializeApp();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
