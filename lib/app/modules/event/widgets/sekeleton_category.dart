import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategoryBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: List.generate(
        4,
        (index) {
          return ShimmerCategoryCard();
        },
      ),
    );
  }
}

class ShimmerCategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            padding: const EdgeInsets.all(15),
            height: 10,
            width: 100,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

// class ShimmerCategoryCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final evC = Get.find<EventController>();

//     return evC.choseKategori.value == "kategoriYgDitampilkan"
//         ? Row(
//         children: [
//           const SizedBox(
//             width: 20.0,
//             height: 20.0,
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             ),
//           ),
//           Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: Container(
//               padding: const EdgeInsets.all(15),
//               // height: 50,
//               width: double.infinity,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 15),
//         ],
//       )
//         : Container();
//   }
// }
