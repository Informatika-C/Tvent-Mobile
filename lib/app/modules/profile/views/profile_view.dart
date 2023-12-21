import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/models/lomba_model.dart';
import '../controllers/profile_controller.dart';
import 'package:tvent/app/models/user_model.dart';
import 'package:responsive_grid/responsive_grid.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: controller.user.value != null
            ? SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        photoProfile(),
                        editButton(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...userInformation(controller.user),
                          const SizedBox(
                            height: 5,
                          ),
                          divider(context),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Lomba yang diikuti :",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ResponsiveStaggeredGridList(
                            desiredItemWidth: 110,
                            minSpacing: 10,
                            children: gridChildren(controller.lomba ?? []),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
            : const Center(
                child: Text('No user'),
              ));
  }
}

List<Widget> userInformation(Rx<User?> user) {
  return [
    Text(
      user.value?.name ?? '',
      style: const TextStyle(fontWeight: FontWeight.w600),
    ),
    Text.rich(
      TextSpan(
        text: "Email : ",
        children: [
          TextSpan(text: user.value?.email ?? ''),
        ],
      ),
    ),
    Text.rich(
      TextSpan(
        text: "NPM : ",
        children: [
          TextSpan(text: user.value?.npm ?? ''),
        ],
      ),
    ),
    Text.rich(
      TextSpan(
        text: "Phone : ",
        children: [
          TextSpan(text: user.value?.phone ?? ''),
        ],
      ),
    )
  ];
}

Widget divider(context) {
  return Padding(
    padding: const EdgeInsets.only(
      right: 50,
    ),
    child: Divider(
      thickness: 2,
      color: Theme.of(context).colorScheme.primary,
    ),
  );
}

List<Container> gridChildren(List<Lomba?> lomba) {
  return List.generate(
    lomba.length,
    (index) => Container(
      decoration: const BoxDecoration(
        color: Color(0XFFf2f2f2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 100,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 114, 114, 114),
              image: DecorationImage(
                image: NetworkImage(lomba[index]?.poster ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lomba[index]?.name ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  Text(
                    lomba[index]?.date ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget photoProfile() {
  return Container(
    height: 100,
    width: 100,
    decoration: const BoxDecoration(
      color: Color(0XFFf2f2f2),
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
  );
}

Widget editButton() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color(0XFFf2f2f2),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: const Icon(
        Icons.edit,
        color: Color(0XFF1E2126),
      ),
    ),
  );
}
