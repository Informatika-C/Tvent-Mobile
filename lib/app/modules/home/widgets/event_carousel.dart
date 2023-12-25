import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tvent/app/modules/home/controllers/home_controller.dart';
import 'package:tvent/app/models/event_model.dart';
import 'package:shimmer/shimmer.dart';

class EventCarousel extends StatefulWidget {
  @override
  _EventCarouselState createState() => _EventCarouselState();
}

class _EventCarouselState extends State<EventCarousel> {
  final HomeController homeController = Get.find();
  final CarouselController _carouselController = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 12.0),
            child: Text(
              "Popular Event",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              enableInfiniteScroll: false,
              autoPlay: false,
              enlargeCenterPage: false,
              aspectRatio: 1,
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 0.93,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            carouselController: _carouselController,
            items: homeController.homeModel.value.popularEvents?.map(
                  (event) {
                    return EventCard(event: event);
                  },
                ).toList() ??
                List.generate(
                  5,
                  (index) => EventCardShimmer(),
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                homeController.homeModel.value.popularEvents?.length ?? 5,
                (index) => buildDot(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      width: _current == index ? 24.0 : 10.0,
      height: 10.0,
      margin: const EdgeInsets.only(left: 9.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: _current == index
            ? Theme.of(context).colorScheme.secondary
            : Colors.grey,
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventModel event;
  final homeController = Get.find<HomeController>();

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(17.0)),
              child: homeController.homeModel.value.popularEvents != null
                  ? Image.network(
                      event.bannerUrl ?? '',
                      height: 120.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 120.0,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.name ?? '',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    event.description ?? '',
                    style: const TextStyle(
                      fontSize: 14.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      homeController.homeModel.value.popularEvents != null
                          ? Image.network(
                              event.organizerImg ?? '',
                              height: 30.0,
                              width: 30.0,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 30.0,
                              width: 30.0,
                              color: Colors.grey[300],
                            ),
                      Text(
                        '\t${event.organizerName ?? ''}',
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(17.0)),
                child: Container(
                  height: 120.0,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 18.0,
                      width: 100.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      height: 14.0,
                      width: 200.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Container(
                          height: 30.0,
                          width: 30.0,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4.0),
                        Container(
                          height: 15.0,
                          width: 100.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
