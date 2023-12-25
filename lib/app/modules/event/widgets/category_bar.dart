import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/event_controller.dart';
import 'package:tvent/app/modules/event/widgets/sekeleton_category.dart';

class CategoryBar extends StatelessWidget {
  final Map<String, dynamic> category;
  final EventController evC = Get.put(EventController());
  late final RxBool checkDetails = false.obs;

  final Key? key;

  CategoryBar({required this.category, this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.2,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              evC.choseKategori.value = category['value'];
              evC.GetEvent(evC.choseKategori.value);
            },
            child: Obx(
              () => Container(
                // height: 50,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: evC.choseKategori.value == category['value']
                      ? Theme.of(context).colorScheme.secondary
                      : const Color(0xfff2f2f2),
                  border: Border.all(
                    color: evC.choseKategori.value == category['value']
                        ? const Color(0xfff2f2f2)
                        : Colors.transparent,
                    width:
                        evC.choseKategori.value == category['value'] ? 1.2 : 0,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: evC.choseKategori.value == category['value']
                          ? const Color.fromARGB(255, 51, 50, 50).withOpacity(1)
                          : const Color.fromARGB(255, 192, 187, 187)
                              .withOpacity(1),
                      offset: const Offset(0, 5),
                      blurRadius: 3,
                      spreadRadius: -4,
                    ),
                  ],
                ),
                child: evC.isLoading.value
                    ? ShimmerCategoryCard()
                    : Row(
                        children: [
                          Icon(
                            category['icon'],
                            color: evC.choseKategori.value == category['value']
                                ? Theme.of(context).colorScheme.tertiary
                                : const Color(0XFF1E2126),
                            size: evC.choseKategori.value == category['value']
                                ? 20
                                : 17,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            category['label'],
                            style: TextStyle(
                              color:
                                  evC.choseKategori.value == category['value']
                                      ? Theme.of(context).colorScheme.tertiary
                                      : const Color(0XFF1E2126),
                              fontWeight:
                                  evC.choseKategori.value == category['value']
                                      ? FontWeight.w900
                                      : FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
