// details.dart

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/event_controller.dart';
import 'package:tvent/app/modules/event/widgets/bottom_sheet.dart';
import 'package:tvent/app/modules/event/widgets/detail_head.dart';
import 'package:tvent/app/modules/event/widgets/event_detail_info.dart';

import '../../../widget/full_image.dart';

class Details extends StatefulWidget {
  final EventController evC = Get.find();
  final void Function(BuildContext) showDetailLomba;

  Details({required this.showDetailLomba});

  // const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final evC = Get.put(EventController());

  Widget _buildEventDetailsHeader() {
    return EventDetailsHeader(
      imageUrl:
          "https://tvent.azurewebsites.net/storage/banner/${evC.DataDetailEvents['id']}/${evC.DataDetailEvents['banner']}",
      onTap: () {
        Get.to(
          () => FullScreenImage(
            imageUrls: [
              "https://tvent.azurewebsites.net/storage/banner/${evC.DataDetailEvents['id']}/${evC.DataDetailEvents['banner']}",
            ],
            initialIndex: 0,
          ),
        );
      },
    );
  }

  // Widget _buildEventDetailsInfo() {
  //   return EventDetailsInfo(
  //     showDetailLomba: BottomSheetHelper.showDetailLomba,
  //   );
  // }
  Widget _buildEventDetailsInfo() {
    final TextEditingController textEditingController = TextEditingController();

    return EventDetailsInfo(
      showDetailLomba: (BuildContext context) {
        BottomSheetHelper.showDetailLomba(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320.0,
            floating: true,
            pinned: true,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.background,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF413a3a).withOpacity(0.6),
                      offset: const Offset(0, 1),
                      blurRadius: 7,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Icon(
                  FontAwesomeIcons.angleLeft,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            foregroundColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 35, sigmaY: 50),
                child: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: const EdgeInsets.all(9),
                  expandedTitleScale: 1.2,
                  title: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.6, horizontal: 20),
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/polygons.png"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF413a3a).withOpacity(0.6),
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Text(
                      // 'iuhasiuhfaso faojshfa sfkjans foaisjflkas foaisjflansf aosjflkasf oaisjflaknsf oaisjflaksfasjf oaksjflajsfoiajs fkalskfa jfalsnf joajsflkas foiajsflansf oasji',
                      "${evC.DataDetailEvents['nama_event']}",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  background: _buildEventDetailsHeader(),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildEventDetailsInfo(),
            ]),
          ),
        ],
      ),
    );
  }
}
