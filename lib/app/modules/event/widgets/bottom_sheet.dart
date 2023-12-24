import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/widgets/dialog_register.dart';

import '../controllers/event_controller.dart';

class BottomSheetHelper {
  static void showDetailLomba(BuildContext context) {
    final evC = Get.find<EventController>();
    List<TextEditingController> cariAnggotaControllers = List.generate(
      evC.DetailLomba['max_anggota'],
      (index) => TextEditingController(),
    );

    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${evC.DetailLomba['nama_lomba']}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    Text("Registration"),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: evC.namaGroup,
                      decoration: InputDecoration(
                        label: Text("Nama Group"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    // TextField(
                    //   controller: evC.cariKetua,
                    //   onChanged: (value) {
                    //     evC.GetUsers(value).then(
                    //       (value) => {
                    //         evC.ketuaCombox.value = value,
                    //       },
                    //     );
                    //   },
                    //   decoration: InputDecoration(
                    //     label: Text("Cari Anggota/Ketua"),
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    // Obx(
                    //   () => Visibility(
                    //     visible: evC.ketuaCombox.isNotEmpty,
                    //     child: Container(
                    //       height: 110,
                    //       decoration: BoxDecoration(
                    //           border: Border.all(
                    //         color: Colors.grey,
                    //         width: 1,
                    //       )),
                    //       child: Obx(
                    //         () => ListView(
                    //           children: List.generate(
                    //             evC.ketuaCombox.length,
                    //             (index) {
                    //               return Obx(
                    //                 () => ListTile(
                    //                   onTap: () {
                    //                     evC.cariKetua.text =
                    //                         "${evC.ketuaCombox[index]['name']}";
                    //                     evC.ketuaCombox.clear();
                    //                   },
                    //                   title: Text(
                    //                     evC.ketuaCombox.isNotEmpty
                    //                         ? "${evC.ketuaCombox[index]['name']}"
                    //                         : "",
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        // ... Fields sebelumnya

                        // Password field, muncul hanya jika anggota kurang dari 2
                        if (evC.DetailLomba['max_anggota'] < 2)
                          TextField(
                            controller: evC.passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              label: Text("Password"),
                              border: OutlineInputBorder(),
                            ),
                          ),

                        // Texfields untuk mencari anggota sejumlah max_anggota
                        for (var index = 0;
                            index < evC.DetailLomba['max_anggota'];
                            index++)
                          Column(
                            children: [
                              TextField(
                                controller: cariAnggotaControllers[index],
                                onChanged: (value) async {
                                  var result = await evC.GetUsers(value);
                                  result.removeWhere((element) =>
                                      element['name'] == evC.cariKetua.text);
                                  evC.PesertaCombox[index].value = result;
                                  if (cariAnggotaControllers[index].text ==
                                      "") {
                                    evC.PesertaCombox[index].clear();
                                  }
                                },
                                decoration: InputDecoration(
                                  label: Text("Cari Anggota ${index + 1}"),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              if (evC.PesertaCombox.length > index)
                                Obx(
                                  () => Visibility(
                                    visible:
                                        evC.PesertaCombox[index].isNotEmpty,
                                    child: Container(
                                      height: 110,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      child: Obx(
                                        () => ListView(
                                          children: List.generate(
                                            evC.PesertaCombox[index].length,
                                            (subIndex) {
                                              return Obx(
                                                () => ListTile(
                                                  onTap: () {
                                                    evC.cariAnggota.text =
                                                        "${evC.PesertaCombox[index][subIndex]['name']}";
                                                    evC.PesertaCombox[index]
                                                        .clear();
                                                  },
                                                  title: Text(
                                                    evC.PesertaCombox.isNotEmpty
                                                        ? "${evC.PesertaCombox[index][subIndex]['name']}"
                                                        : "",
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              SizedBox(height: 10),
                            ],
                          ),

                        // ... Tombol Join Now dan Close
                      ],
                    ),

                    // Column(
                    //   children: List.generate(
                    //     evC.DetailLomba['max_anggota'],
                    //     (index) => Column(
                    //       children: [
                    //         TextField(
                    //           controller: cariAnggotaControllers[index],
                    //           onChanged: (value) async {
                    //             // Use await to get the result of GetUsers
                    //             var result = await evC.GetUsers(value);
                    //             result.removeWhere(
                    //               (element) =>
                    //                   element['name'] == evC.cariKetua.text,
                    //             );
                    //             // Use assign instead of setValue
                    //             evC.PesertaCombox[index].assign(result);
                    //             if (cariAnggotaControllers[index].text == "") {
                    //               evC.PesertaCombox[index].clear();
                    //             }
                    //           },
                    //           decoration: InputDecoration(
                    //             label: Text("Cari Anggota ${index + 1}"),
                    //             border: OutlineInputBorder(),
                    //           ),
                    //         ),
                    //         if (evC.PesertaCombox.length > index)
                    //           Obx(
                    //             () => Visibility(
                    //               visible: evC.PesertaCombox[index].isNotEmpty,
                    //               child: Container(
                    //                 height: 110,
                    //                 decoration: BoxDecoration(
                    //                   border: Border.all(
                    //                     color: Colors.grey,
                    //                     width: 1,
                    //                   ),
                    //                 ),
                    //                 child: Obx(
                    //                   () => ListView(
                    //                     children: List.generate(
                    //                       evC.PesertaCombox.length,
                    //                       (index) {
                    //                         return Obx(
                    //                           () => ListTile(
                    //                             onTap: () {
                    //                               evC.cariAnggota.text =
                    //                                   "${evC.PesertaCombox[index]['name']}";
                    //                               evC.PesertaCombox.clear();
                    //                             },
                    //                             title: Text(
                    //                               evC.PesertaCombox.isNotEmpty
                    //                                   ? "${evC.PesertaCombox[index]['name']}"
                    //                                   : "",
                    //                             ),
                    //                           ),
                    //                         );
                    //                       },
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         SizedBox(height: 10),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    // TextField(
                    //   controller: evC.cariAnggota,
                    //   onChanged: (value) {
                    //     evC.GetUsers(value).then((value) {
                    //       value.removeWhere((element) =>
                    //           element['name'] == evC.cariKetua.text);
                    //       evC.PesertaCombox.value = value;
                    //     });
                    //     if (evC.cariAnggota.text == "") {
                    //       evC.PesertaCombox.clear();
                    //     }
                    //   },
                    //   decoration: InputDecoration(
                    //     label: Text("Cari Anggota"),
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    // Obx(
                    //   () => Visibility(
                    //     visible: evC.PesertaCombox.isNotEmpty,
                    //     child: Container(
                    //       height: 110,
                    //       decoration: BoxDecoration(
                    //           border: Border.all(
                    //         color: Colors.grey,
                    //         width: 1,
                    //       )),
                    //       child: Obx(
                    //         () => ListView(
                    //           children: List.generate(
                    //             evC.PesertaCombox.length,
                    //             (index) {
                    //               return Obx(
                    //                 () => ListTile(
                    //                   onTap: () {
                    //                     evC.cariAnggota.text =
                    //                         "${evC.PesertaCombox[index]['name']}";
                    //                     evC.PesertaCombox.clear();
                    //                   },
                    //                   title: Text(
                    //                     evC.PesertaCombox.isNotEmpty
                    //                         ? "${evC.PesertaCombox[index]['name']}"
                    //                         : "",
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),

                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 220,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(evC.DetailLomba['poster'] !=
                                    null
                                ? "https://tvent.azurewebsites.net/storage/lomba/poster/${evC.DetailLomba['id']}/${evC.DetailLomba['poster']}"
                                : "https://cdn.ebaumsworld.com/mediaFiles/picture/1151541/84693449.png"),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 1,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Room : ${evC.DetailLomba['ruangan_lomba']}"),
                        Text("Group : ${evC.DetailLomba['max_anggota']}"),
                        Text(
                            "Kuota : ${evC.DetailLomba['anggota_terdaftar']} / ${evC.DetailLomba['kuota_lomba']}"),
                        Text(
                            "Start At :${evC.DetailLomba['pelaksanaan_lomba'].toString().substring(0, 10)}"),
                        Text(
                            "${evC.DetailLomba['pelaksanaan_lomba'].toString().substring(11, 19)}"),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  // 'ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ;',
                  "${evC.DetailLomba['keterangan']}",
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),

                // Text(
                //   'ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ; ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ;ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ;ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ; ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ;ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ; ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ; ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ; ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ; ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ; ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ; ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ; ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ; ajsnkfajnsjfas fajsflkjas falsjfuashf oasjfkjasfkj asfijaosifj asfjhb kjf;ia sflkbdsf a;dhg aglkahd g;aijghosg haijpaij ; ',
                //   overflow: TextOverflow.clip,
                //   textAlign: TextAlign.justify,
                //   // "${evC.DetailLomba['keterangan']}"
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        _showJoinNowDialog(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Join Now"),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Close"),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void _showJoinNowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return JoinNowDialog(
          // evC: EventController(),
          onPressed: () {
            print("Join Now button pressed");
          },
        );
      },
    );
  }
}
