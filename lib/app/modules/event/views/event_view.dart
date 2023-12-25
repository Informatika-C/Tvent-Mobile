import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/category_controller.dart';
import 'package:tvent/app/modules/event/model/category_model.dart';
import 'package:tvent/app/modules/event/widgets/category_bar.dart';
import '../controllers/event_controller.dart';
import '../widgets/build_card.dart';
import '../widgets/sekeleton_card.dart';

class EventView extends GetView<EventController> {
  final eventController = Get.put(EventController());
  final categoryController = Get.put(CategoryController());
  late final RxBool checkDetails = false.obs;

  EventView({super.key});

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
                  categoryController.categories.length,
                  (index) => CategoryBar(
                    index: index,
                  ),
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
                  () {
                    CategoryModel currentCategory = categoryController
                        .categories[categoryController.choseKategori.value];

                    return Text(
                      "Best ${currentCategory.name} Event",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
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
            child: Obx(() => eventController.isLoading.value
                ? ShimmerLoadingWidget()
                : EventListWidget()),
          ),
        ],
      ),
    );
  }
}
