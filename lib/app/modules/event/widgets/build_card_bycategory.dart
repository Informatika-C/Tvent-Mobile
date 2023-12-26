import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/event_controller.dart';
import 'package:tvent/app/modules/event/views/event_details_view.dart';
import 'package:tvent/app/models/event_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BuildCardByCategory extends StatelessWidget {
  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        eventController.events.length,
        (index) {
          final EventModel eventData = eventController.events[index];

          return Column(
            children: [
              EventCard(event: eventData),
              const SizedBox(height: 6),
            ],
          );
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventController eventController = Get.find();
  final EventModel event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (event.id == null) {
          Get.snackbar("Error", "Event id is null");
        }
        Get.generalDialog(
          pageBuilder: (context, animation, secondaryAnimation) {
            return Details(
              id: event.id ?? -1,
            );
          },
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: const Color(0xfff2f2f2),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: event.bannerUrl != null
                  ? Image(
                      image: CachedNetworkImageProvider(event.bannerUrl ?? ""),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0XFF1E2126),
                    ),
                  ),
                  Text(
                    event.description ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      color: Color(0XFF1E2126),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      event.organizerImg != null
                          ? Image(
                              image: CachedNetworkImageProvider(
                                  event.organizerImg ?? ""),
                              width: 30,
                              height: 30,
                            )
                          : const SizedBox(width: 30, height: 30),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.organizerName ?? "",
                            style: const TextStyle(
                              color: Color(0XFF1E2126),
                            ),
                          ),
                          Text(
                            event.location ?? "",
                            style: const TextStyle(
                              color: Color(0XFF1E2126),
                            ),
                          ),
                        ],
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
