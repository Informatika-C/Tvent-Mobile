// CombinedWidget.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/event_controller.dart';

class AuthorsDetail extends StatelessWidget {
  final EventController evC = Get.find();

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            "https://tvent.azurewebsites.net/storage/penyelenggara/logo/${evC.DataDetailEvents['penyelenggara']['id']}/${evC.DataDetailEvents['penyelenggara']['logo']}",
            width: 40,
            height: 40,
            colorBlendMode: BlendMode.colorBurn,
          ),
          const SizedBox(width: 7.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Penyelenggara",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              Text(
                "${evC.DataDetailEvents['penyelenggara']['nama_penyelenggara']}",
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
    );
  }
}
