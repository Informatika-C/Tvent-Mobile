import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tvent/app/modules/home/controllers/home_controller.dart';
import '../models/event_model.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0),
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
            enableInfiniteScroll: true,
            autoPlay: true,
            enlargeCenterPage: false,
            aspectRatio: 1,
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          carouselController: _carouselController,
          items: homeController.events.map((event) {
            return EventCard(event: event);
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              homeController.events.length,
              (index) => buildDot(index),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDot(int index) {
    return Container(
      width: _current == index ? 24.0 : 10.0,
      height: 10.0,
      margin: const EdgeInsets.only(left: 5.0),
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

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                event.imageUrl,
                height: 120.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    event.description,
                    style: const TextStyle(fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Image.network(
                        event.authorsImg,
                        height: 30.0,
                        width: 30.0,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        '\t${event.organizer}',
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
