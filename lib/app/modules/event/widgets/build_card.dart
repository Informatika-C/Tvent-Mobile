import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/models/event_model.dart';
import 'package:tvent/app/models/event_models.dart';
import 'package:tvent/app/modules/event/controllers/event_controller.dart';
import 'package:tvent/app/modules/event/views/event_details_view.dart';

class EventListWidget extends StatelessWidget {
  final EventController eventController = Get.put(EventController());

  EventListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
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
        eventController.GetDetailEvent("${event.id}").then(
          (value) => Get.to(
            () => Details(
              showDetailLomba: (BuildContext context) {},
            ),
          ),
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
                  ? Image.network(
                      event.bannerUrl ?? "",
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
                    style: const TextStyle(
                      color: Color(0XFF1E2126),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      event.organizerImg != null
                          ? Image.network(
                              event.organizerImg ?? "",
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
