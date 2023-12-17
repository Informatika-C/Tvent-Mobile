import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/home/controllers/home_controller.dart';
import '../models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top Category",
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
          buildCategoryList(),
        ],
      ),
    );
  }

  Widget buildCategoryList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        homeController.categories.length,
        (index) => buildCategoryItem(homeController.categories[index]),
      ),
    );
  }

  Widget buildCategoryItem(CategoryModel category) {
    return Container(
      width: 83.0,
      height: 83.0,
      decoration: BoxDecoration(
        color: const Color(0XFFf2f2f2),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              category.name,
              style: const TextStyle(
                color: Color(0XFF06142E),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 7.0),
            Icon(
              category.icon,
              size: 20,
              color: const Color(0XFF06142E),
            ),
          ],
        ),
      ),
    );
  }
}
