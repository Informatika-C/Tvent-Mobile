// CombinedWidget.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/event_detail_controller.dart';

class AuthorsDetail extends StatelessWidget {
  final EventDetailController eventDetailController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(9),
      child: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            eventDetailController.event.value.organizerImg == null
                ? const SizedBox(
                    width: 40,
                    height: 40,
                  )
                : Image(
                    image: CachedNetworkImageProvider(
                        eventDetailController.event.value.organizerImg ?? ""),
                    width: 40,
                    height: 40,
                    colorBlendMode: BlendMode.colorBurn,
                  ),
            const SizedBox(width: 7.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventDetailController.event.value.organizerName != null
                      ? "Penyelenggara"
                      : "             ",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                Text(
                  eventDetailController.event.value.organizerName ?? "",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
