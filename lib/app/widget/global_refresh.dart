import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/home/controllers/home_controller.dart';

class GlobalRefreshWidget extends StatelessWidget {
  final Widget child;
  final HomeController homeController = Get.find<HomeController>();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  //     GlobalKey<LiquidPullToRefreshState>();

  GlobalRefreshWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      // key: _refreshIndicatorKey,
      onRefresh: () async {
        await homeController.globalRefresh();
      },
      height: 50.0,
      springAnimationDurationInMilliseconds: 400,
      animSpeedFactor: 8.0,
      showChildOpacityTransition: false,
      color: Theme.of(context).colorScheme.secondary,
      backgroundColor: Colors.white,
      child: child,
      // child: Obx(() {
      //   bool isLoading = Get.find<HomeController>().isLoading.value;
      //   return isLoading ? Center(child: CircularProgressIndicator()) : child;
      // }),
    );
  }
}
