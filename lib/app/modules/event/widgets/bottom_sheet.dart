import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/lomba_controller.dart';
import 'package:tvent/app/modules/event/widgets/bottom_sheet_widget/head_info_lomba.dart';
import 'package:tvent/app/modules/event/widgets/bottom_sheet_widget/guest_field_lomba.dart';
import 'package:tvent/app/modules/event/widgets/bottom_sheet_widget/register_grup_field_lomba.dart';
import 'package:tvent/app/modules/event/widgets/bottom_sheet_widget/register_indiv_field_lomba.dart';
import 'package:tvent/services/auth_services.dart';

class BottomSheetHelper {
  static void showDetailLomba(BuildContext context, int id) {
    AuthServices authService = Get.find<AuthServices>();
    LombaController lombaController = Get.put(LombaController());
    lombaController
        .getLombaDetail(id)
        .onError((error, stackTrace) => onErrorGetLomba);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
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
                  child: Obx(
                    () => Column(
                      children: [
                        HeadInfoBottomSheet(),
                        (authService.user.value == null)
                            ? GuestFieldBottomSheet()
                            : ((lombaController.lomba.value
                                            .maxParticipantPerTeam ??
                                        -1) >
                                    1)
                                ? RegisterGrupFieldLombaBottomSheet(
                                    numberOfTeamMembers: lombaController.lomba
                                            .value.maxParticipantPerTeam ??
                                        0,
                                  )
                                : RegisterIndivFieldBottomShield(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(lombaController.resetData);
  }

  static void onErrorGetLomba(error) {
    Get.snackbar(
      "Error",
      error.toString(),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
