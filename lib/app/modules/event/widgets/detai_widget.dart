import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tvent/app/modules/event/controllers/event_detail_controller.dart';

class EventDetailsWidget extends StatelessWidget {
  final EventDetailController eventDetailController = Get.find();

  EventDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventDetailRow(
              icon: FontAwesomeIcons.calendarCheck,
              // text: _formatDate(
              //     eventDetailController.event.value.registerDate.toString()),
              text: _formatDate(eventDetailController.event.value.registerDate
                      ?.toString()
                      .split(' ')[0] ??
                  ""),
            ),
            const SizedBox(height: 5),
            EventDetailRow(
              icon: FontAwesomeIcons.calendarXmark,
              // text: _formatDate(
              //     eventDetailController.event.value.closeRegisterDate.toString()),
              text: _formatDate(eventDetailController
                      .event.value.closeRegisterDate
                      ?.toString()
                      .split(' ')[0] ??
                  ""),
            ),
            const SizedBox(height: 5),
            EventDetailRow(
              icon: FontAwesomeIcons.fire,
              // text: _formatDate(
              //     eventDetailController.event.value.startDate.toString()),
              text: _formatDate(eventDetailController.event.value.startDate
                      ?.toString()
                      .split(' ')[0] ??
                  ""),
            ),
            const SizedBox(height: 5),
            EventDetailRow(
              icon: FontAwesomeIcons.locationDot,
              text: eventDetailController.event.value.location ?? "",
            ),
          ],
        ),
      ),
    );
  }
}

class EventDetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  EventDetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }
}

String _formatDate(String dateString) {
  if (dateString == "") return "";
  final inputFormat = DateFormat("yyyy-MM-dd");
  final outputFormat = DateFormat("dd MMMM yyyy");
  final DateTime dateTime = inputFormat.parse(dateString);
  return outputFormat.format(dateTime);
}
