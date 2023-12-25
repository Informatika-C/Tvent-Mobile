// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/category_controller.dart';
import 'package:tvent/app/modules/event/controllers/event_controller.dart';
import 'package:tvent/app/modules/event/model/category_model.dart';
import 'package:tvent/app/modules/event/widgets/sekeleton_category.dart';

class CategoryBar extends StatelessWidget {
  final eventController = Get.find<EventController>();
  final categoryController = Get.find<CategoryController>();

  final int index;
  final RxBool isLoading = false.obs;
  final RxBool checkDetails = false.obs;

  late CategoryModel category;

  CategoryBar({
    super.key,
    required this.index,
  }) {
    category = categoryController.categories[index];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.2,
      child: Column(
        children: [
          InkWell(
            onTap: isLoading.value
                ? null
                : () async {
                    try {
                      isLoading.value = true;
                      await categoryController.chageCategory(index);
                    } catch (e) {
                      Get.snackbar(
                        "Error",
                        e.toString(),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } finally {
                      isLoading.value = false;
                    }
                  },
            child: Obx(() {
              CategoryModel currentCategory = categoryController
                  .categories[categoryController.choseKategori.value];

              return Container(
                // height: 50,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: currentCategory.name == category.name
                      ? Theme.of(context).colorScheme.secondary
                      : const Color(0xfff2f2f2),
                  border: Border.all(
                    color: currentCategory.name == category.name
                        ? const Color(0xfff2f2f2)
                        : Colors.transparent,
                    width: currentCategory.name == category.name ? 1.2 : 0,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: currentCategory.name == category.name
                          ? const Color.fromARGB(255, 51, 50, 50).withOpacity(1)
                          : const Color.fromARGB(255, 192, 187, 187)
                              .withOpacity(1),
                      offset: const Offset(0, 5),
                      blurRadius: 3,
                      spreadRadius: -4,
                    ),
                  ],
                ),
                child: isLoading.value
                    ? ShimmerCategoryCard()
                    : Row(
                        children: [
                          Icon(
                            category.icon,
                            color: currentCategory.name == category.name
                                ? Theme.of(context).colorScheme.tertiary
                                : const Color(0XFF1E2126),
                            size:
                                currentCategory.name == category.name ? 20 : 17,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            category.label,
                            style: TextStyle(
                              color: currentCategory.name == category.name
                                  ? Theme.of(context).colorScheme.tertiary
                                  : const Color(0XFF1E2126),
                              fontWeight: currentCategory.name == category.name
                                  ? FontWeight.w900
                                  : FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
              );
            }),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
