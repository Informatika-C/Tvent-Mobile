import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/models/user_model.dart';
import 'package:tvent/app/modules/event/controllers/lomba_controller.dart';
import 'package:tvent/app/modules/event/controllers/register_grup_controller.dart';
import 'package:tvent/app/modules/event/controllers/register_indiv_controller.dart';
import 'package:tvent/app/modules/event/widgets/bottom_sheet_widget/head_info_lomba.dart';
import 'package:tvent/app/modules/event/widgets/bottom_sheet_widget/guest_field_lomba.dart';
import 'package:tvent/app/modules/event/widgets/bottom_sheet_widget/register_grup_field_lomba.dart';
import 'package:tvent/app/modules/event/widgets/bottom_sheet_widget/register_indiv_field_lomba.dart';
import 'package:tvent/app/modules/event/widgets/bottom_sheet_widget/already_register_lomba.dart';
import 'package:tvent/services/auth_services.dart';

class BottomSheetHelper {
  static void showDetailLomba(BuildContext context, int id) {
    AuthServices authService = Get.find<AuthServices>();
    LombaController lombaController = Get.put(LombaController());

    RegisterIndivController registerIndivController =
        Get.put(RegisterIndivController());

    RegisterGrupController registerGrupController =
        Get.put(RegisterGrupController());

    lombaController
        .getLombaDetail(id)
        .onError((error, stackTrace) => onErrorGetLomba);

    registerGrupController.members.value = List.generate(
        lombaController.lomba.value.maxParticipantPerTeam ?? 0,
        (index) => User());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          shouldCloseOnMinExtent: true,
          initialChildSize: 0.6,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    height: 4,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Obx(
                        () => Column(
                          children: [
                            HeadInfoBottomSheet(),
                            (authService.user.value == null)
                                ? GuestFieldBottomSheet()
                                : lombaController.lomba.value.isRegistered ==
                                        null
                                    ? const Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : lombaController
                                                .lomba.value.isRegistered ==
                                            true
                                        ? AlreadyRegisBottomSheet(id: id)
                                        : ((lombaController.lomba.value
                                                        .maxParticipantPerTeam ??
                                                    -1) >
                                                1)
                                            ? RegisterGrupFieldLombaBottomSheet(
                                                numberOfTeamMembers: lombaController
                                                        .lomba
                                                        .value
                                                        .maxParticipantPerTeam ??
                                                    0,
                                                id: id,
                                                registerGrupController:
                                                    registerGrupController,
                                              )
                                            : RegisterIndivFieldBottomShield(
                                                id: id),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      lombaController.resetData();
      registerGrupController.resetData();
      registerIndivController.resetData();
    });

    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   enableDrag: true,
    //   clipBehavior: Clip.antiAliasWithSaveLayer,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(
    //       top: Radius.circular(50),
    //     ),
    //   ),
    //   builder: (BuildContext context) {
    //     return SingleChildScrollView(
    //       child: Container(
    //         height: MediaQuery.of(context).size.height * 0.6,
    //         padding: const EdgeInsets.symmetric(horizontal: 12),
    //         child: Column(
    //           children: [
    //             Container(
    //               margin: const EdgeInsets.symmetric(vertical: 12),
    //               alignment: Alignment.center,
    //               height: 4,
    //               width: MediaQuery.of(context).size.width * 0.2,
    //               decoration: BoxDecoration(
    //                 color: Colors.black,
    //                 borderRadius: BorderRadius.circular(2),
    //               ),
    //             ),
    //             Expanded(
    //               child: SingleChildScrollView(
    //                 child: Obx(
    //                   () => Column(
    //                     children: [
    //                       HeadInfoBottomSheet(),
    //                       // if user is guest
    //                       (authService.user.value == null)
    //                           ? GuestFieldBottomSheet()
    //                           // if user is not guest
    //                           : lombaController.lomba.value.isRegistered == null
    //                               ? const Padding(
    //                                   padding: EdgeInsets.only(top: 20),
    //                                   child: Center(
    //                                     child: CircularProgressIndicator(),
    //                                   ),
    //                                 )
    //                               // if user is registered
    //                               : lombaController.lomba.value.isRegistered ==
    //                                       true
    //                                   ? AlreadyRegisBottomSheet(id: id)
    //                                   // if user is not registered
    //                                   : ((lombaController.lomba.value
    //                                                   .maxParticipantPerTeam ??
    //                                               -1) >
    //                                           1)
    //                                       // if lomba is grup
    //                                       ? RegisterGrupFieldLombaBottomSheet(
    //                                           numberOfTeamMembers: lombaController
    //                                                   .lomba
    //                                                   .value
    //                                                   .maxParticipantPerTeam ??
    //                                               0,
    //                                           id: id,
    //                                           registerGrupController:
    //                                               registerGrupController,
    //                                         )
    //                                       // if lomba is indiv
    //                                       : RegisterIndivFieldBottomShield(
    //                                           id: id),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // ).whenComplete(() {
    //   lombaController.resetData();
    //   registerGrupController.resetData();
    //   registerIndivController.resetData();
    // });
  }

  static void onErrorGetLomba(error) {
    Get.snackbar(
      "Error",
      error.toString(),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
