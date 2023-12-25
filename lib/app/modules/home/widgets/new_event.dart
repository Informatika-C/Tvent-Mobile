import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/home/controllers/home_controller.dart';
import 'package:shimmer/shimmer.dart';

class CardList extends StatelessWidget {
  final HomeController homeController = Get.find();

  CardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "New Event",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFFFA500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(6.0),
                ),
                child: const Text("See All"),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8.0),
          height: 180.0,
          width: double.infinity,
          child: Obx(
            () => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeController.homeModel.value.newEvents?.length ?? 5,
              itemBuilder: (context, index) {
                if (homeController.homeModel.value.newEvents?.length == null) {
                  return const CardItemShimmer();
                } else {
                  return CardItem(index);
                }
              },
            ),
          ),
        )
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  final int index;
  final homeController = Get.find<HomeController>();

  CardItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 250.0,
        height: 180.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image:
              homeController.homeModel.value.newEvents?[index].bannerUrl != null
                  ? DecorationImage(
                      image: NetworkImage(
                        homeController
                                .homeModel.value.newEvents?[index].bannerUrl ??
                            '',
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
        ),
        child: Center(
          child: Text(
            homeController.homeModel.value.newEvents?[index].name ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// make card item shimmer
class CardItemShimmer extends StatelessWidget {
  const CardItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          width: 250.0,
          height: 180.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
