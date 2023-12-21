import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/home/controllers/home_controller.dart';
import '../models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  final HomeController homeController = Get.find();

  CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      padding: const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 12.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/polygons.png"),
          fit: BoxFit.cover,
          alignment: Alignment.centerRight,
          repeat: ImageRepeat.noRepeat,
        ),
      ),
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
          const Center(
            child: Text(
              "The following are categories that always exist every year.",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategoryList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isNarrowScreen = screenWidth < 360;
        final columnCount = isNarrowScreen ? 2 : 4;
        final crossAxisExtent = isNarrowScreen ? 83.0 : 84.0;
        final maxHeight = isNarrowScreen ? 182.0 : 85.0;
        final padding = isNarrowScreen
            ? const EdgeInsets.symmetric(horizontal: 20.0)
            : EdgeInsets.zero;

        return Container(
          constraints: BoxConstraints(maxHeight: maxHeight),
          padding: padding,
          margin: const EdgeInsets.only(top: 5.0, bottom: 12.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
              mainAxisExtent: crossAxisExtent,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: crossAxisExtent / maxHeight,
            ),
            itemCount: homeController.categories.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return buildCategoryItem(homeController.categories[index]);
            },
          ),
        );
      },
    );
  }

  Widget buildCategoryItem(CategoryModel category) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0XFFf2f2f2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                category.name,
                style: const TextStyle(
                  color: Color(0XFF06142E),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                maxLines: 1,
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
