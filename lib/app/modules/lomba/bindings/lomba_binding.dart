import 'package:get/get.dart';

import '../controllers/lomba_controller.dart';

class LombaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LombaController>(
      () => LombaController(),
    );
  }
}
