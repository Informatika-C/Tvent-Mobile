import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/models/event_models.dart';
import 'package:tvent/app/modules/event/controllers/event_controller.dart';
import 'package:tvent/app/modules/event/views/event_details_view.dart';

class EventListWidget extends StatelessWidget {
  final EventController evC = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        evC.dataKategoriEvents.length,
        (index) {
          final DataKategoriEvent eventData = evC.dataKategoriEvents[index];

          return Column(
            children: [
              EventCard(eventData: eventData),
              const SizedBox(height: 6),
            ],
          );
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final DataKategoriEvent eventData;
  final EventController evC = Get.find();

  EventCard({required this.eventData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        evC.GetDetailEvent("${eventData.id}").then(
          (value) => Get.to(() => const Details()),
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
              child: Image.network(
                eventData.getBannerUrl(),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventData.namaEvent,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0XFF1E2126),
                    ),
                  ),
                  Text(
                    eventData.deskripsi,
                    style: const TextStyle(
                      color: Color(0XFF1E2126),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Image.network(
                        eventData.getPenyelenggaraLogoUrl(),
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventData.penyelenggara['nama_penyelenggara'],
                            style: const TextStyle(
                              color: Color(0XFF1E2126),
                            ),
                          ),
                          Text(
                            eventData.tempat,
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
