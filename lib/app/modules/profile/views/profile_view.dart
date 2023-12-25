import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:tvent/app/models/lomba_model.dart';
import 'package:tvent/app/models/user_model.dart';
import 'package:tvent/app/modules/profile/controllers/profile_controller.dart';
import 'package:tvent/app/widget/full_image.dart';
import 'package:tvent/services/theme.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final controller = Get.put(ProfileController());
  bool isCardView = true;
  @override
  void dispose() {
    controller.resetExpansionStates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: controller.user.value != null
            ? Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        image: const DecorationImage(
                          image: AssetImage("assets/images/polygons.png"),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 51, 50, 50)
                                .withOpacity(1),
                            offset: const Offset(0, 6),
                            blurRadius: 7,
                            spreadRadius: -4,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          photoProfile(),
                          ...userInformation(controller.user, context),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12.0),
                      child: Column(
                        children: [
                          controller.isLoading.value
                              ? Center(
                                  heightFactor:
                                      MediaQuery.of(context).size.height / 60,
                                  child: const CircularProgressIndicator(),
                                )
                              : controller.lomba.isEmpty
                                  ? Center(
                                      heightFactor:
                                          MediaQuery.of(context).size.height /
                                              130,
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Belum ada lomba yang diikuti",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 16),
                                          Icon(FontAwesomeIcons.ghost,
                                              size: 50),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Lomba yang diikuti :",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            ToggleButtons(
                                              constraints:
                                                  const BoxConstraints.tightFor(
                                                      height: 40, width: 40),
                                              isSelected: [
                                                isCardView,
                                                !isCardView
                                              ],
                                              onPressed: (index) {
                                                setState(() {
                                                  isCardView = index == 0;
                                                  if (isCardView) {
                                                    controller
                                                        .resetExpansionStates();
                                                  }
                                                });
                                              },
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              selectedColor: Colors.white,
                                              fillColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              renderBorder: false,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              children: const [
                                                Icon(
                                                  FontAwesomeIcons.gripVertical,
                                                  size: 17,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.list,
                                                  size: 17,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        isCardView
                                            ? ResponsiveStaggeredGridList(
                                                desiredItemWidth: 150,
                                                minSpacing: 10,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: gridChildren(
                                                    controller.lomba ?? []),
                                              )
                                            : Column(
                                                children: gridChildren(
                                                    controller.lomba ?? []),
                                              ),
                                      ],
                                    ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: Text('No user'),
              ),
      ),
    );
  }

  List<Widget> userInformation(Rx<User?> user, BuildContext context) {
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              user.value?.name ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              overflow: TextOverflow.clip,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userInfo("Email"),
                  userInfo("NPM"),
                  userInfo("Phone"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userVal(user.value?.email),
                  userVal(user.value?.npm),
                  userVal(user.value?.phone),
                ],
              ),
            ],
          ),
        ],
      ),
    ];
  }

  Widget userInfo(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget userVal(String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "\t:\t",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value ?? '',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  List<Widget> gridChildren(List<LombaModel?> lomba) {
    if (controller.isLoading.value) {
      return [
        Center(
          heightFactor: MediaQuery.of(context).size.height / 60,
          child: const CircularProgressIndicator(),
        ),
      ];
    }

    if (controller.isLoading.value) {
      controller.getLomba();
      controller.resetExpansionStates();
    }

    return List.generate(
      lomba.length,
      (index) => isCardView
          ? buildCardView(lomba[index])
          : buildListView(lomba[index]),
    );
  }

  Widget buildCardView(LombaModel? lomba) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(lomba?.poster ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                lomba?.name ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                lomba?.date != null
                    ? DateFormat('EEEE, dd MMMM yyyy HH:mm:ss')
                        .format(DateTime.parse(lomba?.date ?? ''))
                    : '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildListView(LombaModel? lomba) {
    bool isExpanded = controller.expansionStates[lomba?.id ?? -1] ?? false;

    return Column(
      children: [
        ExpansionTile(
          trailing: isExpanded
              ? const Icon(FontAwesomeIcons.caretUp)
              : const Icon(FontAwesomeIcons.caretDown),
          expandedAlignment: Alignment.centerLeft,
          tilePadding: const EdgeInsets.symmetric(vertical: 10),
          childrenPadding: EdgeInsets.zero,
          onExpansionChanged: (value) {
            controller.toggleExpansion(value, lomba?.id ?? -1);
          },
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            title: isExpanded
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.all(Radius.circular(9)),
                    ),
                    child: Text(
                      lomba?.name ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  )
                : Text(
                    lomba?.name ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
            subtitle: isExpanded
                ? null
                : Text(
                    lomba?.date != null
                        ? DateFormat('EEEE, dd MMMM yyyy HH:mm:ss')
                            .format(DateTime.parse(lomba?.date ?? ''))
                        : '',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
            leading: isExpanded
                ? null
                : Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        image: NetworkImage(lomba?.poster ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => FullScreenImage(
                            imageUrls: [lomba?.poster ?? ''],
                            initialIndex: 0,
                          ),
                        );
                      },
                      child: Image.network(
                        lomba?.poster ?? '',
                        height: 210,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(left: 16.0),
                      width: MediaQuery.of(context).size.width - 32.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text(
                              '#ID ${lomba?.id}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(lomba?.description ?? ''),
                              Text(
                                lomba?.date != null
                                    ? DateFormat('EEEE, dd MMMM yyyy HH:mm:ss')
                                        .format(
                                            DateTime.parse(lomba?.date ?? ''))
                                    : '',
                              ),
                              Text(lomba?.price.toString() ?? ''),
                              Text(lomba?.kuota.toString() ?? ''),
                              Text(lomba?.maxParticipantPerTeam.toString() ??
                                  ''),
                              Text(
                                lomba?.location ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Themes.light.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 2.0,
                            ),
                            child: const Text('Out'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 1,
          height: 0,
          color: Colors.grey,
        ),

        // Container di sini
      ],
    );
  }

  Widget photoProfile() {
    return InkWell(
      onTap: () {
        Get.to(
          () => FullScreenImage(
            imageUrls: const [
              'https://avatars.githubusercontent.com/u/101344946?v=4'
            ],
            initialIndex: 0,
          ),
        );
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 79, 77, 77).withOpacity(1),
              offset: const Offset(2.5, 4),
              blurRadius: 7,
              spreadRadius: -3,
            ),
          ],
          image: const DecorationImage(
            image: NetworkImage(
              'https://avatars.githubusercontent.com/u/101344946?v=4',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
