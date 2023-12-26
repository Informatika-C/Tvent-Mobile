// event_details_header.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EventDetailsHeader extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onTap;

  EventDetailsHeader({required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: imageUrl != null
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                  image: imageUrl != null
                      ? DecorationImage(
                          alignment: Alignment.topCenter,
                          image: NetworkImage(imageUrl ?? ""),
                          fit: BoxFit.cover,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromARGB(255, 50, 49, 49).withOpacity(1),
                      offset: const Offset(2, 3),
                      blurRadius: 7,
                      spreadRadius: -2,
                    ),
                  ]),
            )
          : ShimmerContainer(),
    );
  }
}

// make shimmer Container

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE0E0E0),
      highlightColor: const Color(0xFFF5F5F5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
