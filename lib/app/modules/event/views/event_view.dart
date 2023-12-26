import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/category_controller.dart';
import 'package:tvent/app/modules/event/model/category_model.dart';
import 'package:tvent/app/modules/event/widgets/category_bar.dart';
import 'package:tvent/app/modules/event/widgets/collaps_tools.dart';
import 'package:tvent/app/modules/event/widgets/search_all_event.dart';
import 'package:tvent/app/modules/event/widgets/sekeleton_category.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/widgets/carrousel_event.dart';
import '../controllers/event_controller.dart';
import '../widgets/build_card_bycategory.dart';
import '../widgets/sekeleton_card.dart';

class EventView extends StatefulWidget {
  // EventView({this.key}) : super(key: key);

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView>
    with SingleTickerProviderStateMixin {
  final eventController = Get.put(EventController());
  final categoryController = Get.put(CategoryController());
  late final RxBool checkDetails = false.obs;
  final HomeController homeController = Get.find();
  final ScrollController _scrollController = ScrollController();
  final double _appBarMaxHeight = 100.0;
  late FocusNode _searchFocus;

  late final AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _searchFocus = FocusNode();
    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _scrollController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeModel = homeController.homeModel;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 5.0),
                  child: Obx(
                    () => Wrap(
                      runSpacing: 6,
                      spacing: 6,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        categoryController.categories.length,
                        (index) => CategoryBar(
                          index: index,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(thickness: 2),
                SearchAll(
                  focusNode: _searchFocus,
                  onTap: () {
                    FocusScope.of(context).requestFocus(_searchFocus);
                  },
                ),
              ],
            ),
          ),
          SliverAppBar(
            expandedHeight: _appBarMaxHeight,
            floating: false,
            pinned: true,
            stretch: true,
            collapsedHeight: 80,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            elevation: 1,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.blurBackground,
              ],
              centerTitle: true,
              titlePadding: EdgeInsets.zero,
              expandedTitleScale: 1.02,
              collapseMode: CollapseMode.parallax,
              background: Obx(
                () => homeModel.value.popularEvents != null
                    ? Carousel(
                        images: homeModel.value.popularEvents!
                            .map((e) => e.bannerUrl!)
                            .toList())
                    : ShimmerCarousel(),
              ),
              title: LayoutBuilder(
                builder: (context, constraints) {
                  final double percentage =
                      (_appBarMaxHeight - constraints.biggest.height);
                  final bool showTitle = percentage > 0.9; // Adjust as needed

                  if (showTitle) {
                    _slideController.forward();
                  } else {
                    _slideController.reverse();
                  }

                  return Stack(
                    children: [
                      Container(
                        color: Colors.transparent,
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 7,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -1),
                            end: const Offset(0, 0),
                          ).animate(_slideController),
                          child: Obx(
                            () => Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                border: Border.all(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? const Color.fromARGB(255, 51, 50, 50)
                                          .withOpacity(1)
                                      : Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(17)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color.fromARGB(
                                                255, 165, 163, 163)
                                            .withOpacity(0.5)
                                        : const Color.fromARGB(255, 51, 50, 50)
                                            .withOpacity(1),
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                    spreadRadius: -2,
                                  ),
                                ],
                              ),
                              child: eventController.isLoading.value
                                  ? ShimmerCategoryCard()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          spacing: 5,
                                          alignment: WrapAlignment.spaceBetween,
                                          children: List.generate(
                                            1,
                                            (index) => CollapsSearchAll(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(_searchFocus);
                                              },
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => Wrap(
                                            spacing: 5,
                                            alignment:
                                                WrapAlignment.spaceBetween,
                                            children: List.generate(
                                              categoryController
                                                  .categories.length,
                                              (index) =>
                                                  CollapsTools(index: index),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
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
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 3.0),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Obx(
                    () => eventController.isLoading.value
                        ? ShimmerLoadingWidget()
                        : BuildCardByCategory(),
                  );
                },
                childCount: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
