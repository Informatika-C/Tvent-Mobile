import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Obx(
          () {
            if (controller.isInitialized.value) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.offNamed('/');
              });
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  curve: Curves.bounceInOut,
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 900),
                  builder: (context, double value, child) {
                    return Column(
                      children: [
                        Opacity(
                          opacity: value,
                          child: Text(
                            'Tvent',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 60,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(
                                  color: const Color.fromARGB(85, 0, 0, 0)
                                      .withOpacity(0.45),
                                  offset: const Offset(2, 2),
                                  blurRadius: 2.5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: value,
                          child: Container(
                            height: 18,
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(85, 0, 0, 0)
                                      .withOpacity(0.45),
                                  offset: const Offset(2, 3),
                                  blurRadius: 2.5,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
