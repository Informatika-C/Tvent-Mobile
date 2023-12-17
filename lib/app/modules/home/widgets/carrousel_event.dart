import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tvent/app/modules/home/controllers/home_controller.dart';

class CarouselImageWidget extends StatelessWidget {
  final HomeController homeController = Get.find();

  CarouselImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var images = homeController.carouselImages;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Carousel(
        images: images,
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
        return Image.network(
          image,
          fit: BoxFit.cover,
          width: double.infinity,
        );
      }).toList(),
      options: CarouselOptions(
        height: 200.0,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}
