import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/widgets/category_bar.dart';
import '../controllers/event_controller.dart';
import '../widgets/build_card.dart';
import '../widgets/sekeleton_card.dart';

class EventView extends GetView<EventController> {
  final Key? key;
  final evC = Get.put(EventController());
  late final RxBool checkDetails = false.obs;

  EventView({this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 10.0),
            child: Obx(
              () => Wrap(
                runSpacing: -6,
                alignment: WrapAlignment.spaceBetween,
                children: List.generate(
                  evC.categories.length,
                  (index) => CategoryBar(category: evC.categories[index]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    "Best ${evC.choseKategori.value} Event",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // evC.GetEvent();
                  },
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 3.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(
              () => evC.isLoading.value
                  ? ShimmerLoadingWidget()
                  : EventListWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
