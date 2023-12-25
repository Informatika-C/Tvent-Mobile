import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/event_controller.dart';
import 'package:tvent/app/modules/event/widgets/sekeleton_category.dart';

class CollapsTools extends StatelessWidget {
  final Map<String, dynamic> category;
  final EventController evC = Get.put(EventController());
  late final RxBool checkDetails = false.obs;

  final Key? key;

  CollapsTools({required this.category, this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        evC.choseKategori.value = category['value'];
        evC.GetEvent(evC.choseKategori.value);
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: evC.choseKategori.value == category['value']
                ? Theme.of(context).colorScheme.secondary
                : const Color(0xfff2f2f2),
            border: Border.all(
              color: evC.choseKategori.value == category['value']
                  ? const Color(0xfff2f2f2)
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: evC.choseKategori.value == category['value']
                    ? const Color.fromARGB(255, 51, 50, 50).withOpacity(1)
                    : const Color.fromARGB(255, 192, 187, 187).withOpacity(1),
                offset: const Offset(0, 5),
                blurRadius: 3,
                spreadRadius: -4,
              ),
            ],
          ),
          child: evC.isLoading.value
              ? ShimmerCategoryCard()
              : Icon(
                  category['icon'],
                  color: evC.choseKategori.value == category['value']
                      ? Theme.of(context).colorScheme.tertiary
                      : const Color(0XFF1E2126),
                  size: 17,
                ),
        ),
      ),
    );
  }
}

class CollapsSearchAll extends StatelessWidget {
   final VoidCallback onTap;

CollapsSearchAll({required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10.6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: Border.all(color: const Color(0xfff2f2f2)),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 192, 187, 187).withOpacity(1),
                  offset: const Offset(0, 5),
                  blurRadius: 3,
                  spreadRadius: -4,
                ),
              ],
            ),
            child: Icon(
              FontAwesomeIcons.cube,
              color: Theme.of(context).colorScheme.secondary,
              size: 25,
            ),
          ),
          const SizedBox(width: 5),
          InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                border: Border.all(color: const Color(0xfff2f2f2)),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 192, 187, 187).withOpacity(1),
                    offset: const Offset(0, 5),
                    blurRadius: 3,
                    spreadRadius: -4,
                  ),
                ],
              ),
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Theme.of(context).colorScheme.secondary,
                size: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
