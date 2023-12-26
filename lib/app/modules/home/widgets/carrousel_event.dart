import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tvent/app/modules/home/controllers/home_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselImageWidget extends StatelessWidget {
  final HomeController homeController = Get.find();

  CarouselImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeModel = homeController.homeModel;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Obx(
        () => homeModel.value.popularEvents != null
            ? Carousel(
                images: homeModel.value.popularEvents!
                    .map((e) => e.bannerUrl!)
                    .toList())
            : ShimmerCarousel(),
      ),
    );
  }
}

class Carousel extends StatelessWidget {
  final List<String> images;

  Carousel({required this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map<Widget>((image) {
        return Image(
          image: CachedNetworkImageProvider(image),
          fit: BoxFit.cover,
          width: double.infinity,
        );
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        enlargeCenterPage: false,
        height: 100.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeOutSine,
        scrollPhysics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}

class ShimmerCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
          .map<Widget>((_) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  color: Colors.white,
                ),
              ))
          .toList(),
      options: CarouselOptions(
        height: 50.0,
        viewportFraction: 0.3,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeOutSine,
        scrollPhysics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
