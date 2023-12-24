// event_details_header.dart

import 'package:flutter/material.dart';

class EventDetailsHeader extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  EventDetailsHeader({required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 50, 49, 49).withOpacity(1),
                offset: const Offset(2, 3),
                blurRadius: 7,
                spreadRadius: -2,
              ),
            ]),
      ),
    );
  }
}
