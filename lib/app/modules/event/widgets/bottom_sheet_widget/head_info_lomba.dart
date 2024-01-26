import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/lomba_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tvent/app/widget/full_image.dart';

class HeadInfoBottomSheet extends StatelessWidget {
  final lomba = Get.find<LombaController>().lomba;

  HeadInfoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20),
          Text(
            lomba.value.name ?? "",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  if (lomba.value.poster == null) return;
                  Get.to(
                    () => FullScreenImage(
                      imageUrls: [lomba.value.poster ?? ''],
                      initialIndex: 0,
                    ),
                  );
                },
                child: Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    image: lomba.value.poster != null
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                                lomba.value.poster ?? ''),
                            fit: BoxFit.fill,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\t Room \t ${lomba.value.location ?? ''}",
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                        "\t Group \t Max ${lomba.value.maxParticipantPerTeam}"),
                    Text(
                        "\t Kouta \t ${lomba.value.currentParticipant ?? 0}/${lomba.value.kuota}"),
                    Text(
                        "\t Start At \t ${lomba.value.startDate.toString().split(' ')[0]}")
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            lomba.value.description ?? "",
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
