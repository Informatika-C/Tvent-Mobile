// AnimatedTextKit(
//                 animatedTexts: [
//                   TyperAnimatedText(
//                     'Hi!',
//                     textStyle: const TextStyle(
//                       color: Colors.red,
//                       fontSize: 24.0,
//                     ),
//                     speed: const Duration(milliseconds: 500),
//                     curve: Curves.linear,
//                   ),
//                   TyperAnimatedText(
//                     'Joint With Us',
//                     textStyle: const TextStyle(
//                       color: Colors.red,
//                       fontSize: 28.0,
//                       fontWeight: FontWeight.w900,
//                     ),
//                     speed: const Duration(milliseconds: 300),
//                   ),
//                 ],
//                 isRepeatingAnimation: false,
//               ),



//     Widget buildPortraitLayout(BuildContext context) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Positioned(
//             top: 40,
//             child: Text(
//               "TVENT",
//               style: TextStyle(
//                 color: Theme.of(context).colorScheme.primary,
//                 fontSize: 45,
//                 fontWeight: FontWeight.w800,
//                 shadows: [
//                   Shadow(
//                     color: Theme.of(context).colorScheme.surfaceVariant,
//                     offset: const Offset(-4.0, 4.0),
//                     blurRadius: 0,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 40.0),
//           Obx(() => Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: isLogin.value ? login : register,
//               )),
//         ],
//       );
//     }

//     Widget buildLandscapeLayout(BuildContext context) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Flexible(
//             fit: FlexFit.loose,
//             child: Obx(() => Padding(
//                   padding: const EdgeInsets.only(left: 20.0),
//                   child: isLogin.value ? login : register,
//                 )),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 36.0, right: 36.0),
//             child: Text(
//               "TVENT",
//               style: TextStyle(
//                 color: Theme.of(context).colorScheme.primary,
//                 fontSize: 100,
//                 fontWeight: FontWeight.w800,
//                 shadows: [
//                   Shadow(
//                     color: Theme.of(context).colorScheme.surfaceVariant,
//                     offset: const Offset(-8.0, 8.0),
//                     blurRadius: 0,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );
//     }

//     body: Center(
//         child: OrientationBuilder(
//           builder: (context, orientation) {
//             final bool isLandscape = MediaQuery.of(context).size.width > 770;
//             return SingleChildScrollView(
//               child: isLandscape
//                   ? buildLandscapeLayout(context)
//                   : buildPortraitLayout(context),
//             );
//           },
//         ),
//       ),

// List<Widget> userInformation(Rx<User?> user, BuildContext context) {
//   return [
//     Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 200,
//           child: Text(
//             user.value?.name ?? '',
//             style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
//             overflow: TextOverflow.clip,
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 userInfo("Email"),
//                 userInfo("NPM"),
//                 userInfo("Phone"),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 userVal(user.value?.email),
//                 userVal(user.value?.npm),
//                 userVal(user.value?.phone),
//               ],
//             ),
//           ],
//         ),
//       ],
//     ),
//   ];
// }

// Widget userInfo(String label) {
//   return Text(
//     label,
//     style: const TextStyle(
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//     ),
//   );
// }

// Widget userVal(String? value) {
//   return Row(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//       const Text(
//         ":\t",
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//           color: Colors.black,
//         ),
//       ),
//       Text(
//         value ?? '',
//         style: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     ],
//   );
// }

// List<Widget> gridChildren(List<Lomba?> lomba) {
//   return List.generate(
//     lomba.length,
//     (index) => Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       elevation: 3,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             height: 100,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//               image: DecorationImage(
//                 image: NetworkImage(lomba[index]?.poster ?? ''),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   lomba[index]?.name ?? '',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   lomba[index]?.date ?? '',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

  // List<Widget> gridChildren(List<Lomba?> lomba) {
  //   return List.generate(
  //     lomba.length,
  //     (index) => Card(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //       elevation: 3,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           Container(
  //             height: 100,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
  //               image: DecorationImage(
  //                 image: NetworkImage(lomba[index]?.poster ?? ''),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(10),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   lomba[index]?.name ?? '',
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.w600,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //                 SizedBox(height: 5),
  //                 Text(
  //                   lomba[index]?.date ?? '',
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.w600,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
// currentAccountPicture: InkWell(
//               onTap: () {
//                 Get.to(
//                   () => FullScreenImage(
//                     imageUrls: const [
//                       'https://avatars.githubusercontent.com/u/101344946?v=4'
//                     ],
//                     initialIndex: 0,
//                   ),
//                 );
//               },
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8.0),
//                 child: Image.network(
//                   'https://avatars.githubusercontent.com/u/101344946?v=4',
//                   width: 52.0,
//                   height: 52.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

            // Obx(
            //   () => Column(
            //     children: List.generate(
            //       EvC.DataKategoriEvents.length,
            //       (index) => InkWell(
            //         onTap: () {
            //           EvC.GetDetailEvent(
            //                   "${EvC.DataKategoriEvents[index]['id']}")
            //               .then(
            //             (value) => Get.to(() => Details()),
            //           );
            //         },
            //         child: Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15),
            //             color: Colors.white,
            //           ),
            //           clipBehavior: Clip.antiAlias,
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Image.network(
            //                 "https://tvent.azurewebsites.net/storage/banner/${EvC.DataKategoriEvents[index]['id']}/${EvC.DataKategoriEvents[index]['banner']}",
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.all(10),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       EvC.DataKategoriEvents[index]['nama_event'],
            //                       style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 16,
            //                         color:
            //                             Theme.of(context).colorScheme.primary,
            //                       ),
            //                     ),
            //                     Text(
            //                       EvC.DataKategoriEvents[index]['deskripsi'],
            //                       style: TextStyle(
            //                         color:
            //                             Theme.of(context).colorScheme.primary,
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       height: 15,
            //                     ),
            //                     Row(
            //                       children: [
            //                         Image.network(
            //                           "https://tvent.azurewebsites.net/storage/penyelenggara/logo/${EvC.DataKategoriEvents[index]['penyelenggara']['id']}/${EvC.DataKategoriEvents[index]['penyelenggara']['logo']}",
            //                           width: 30,
            //                           height: 30,
            //                         ),
            //                         SizedBox(
            //                           width: 10,
            //                         ),
            //                         Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             Text(
            //                               EvC.DataKategoriEvents[index]
            //                                       ['penyelenggara']
            //                                   ['nama_penyelenggara'],
            //                               style: TextStyle(
            //                                 color: Theme.of(context)
            //                                     .colorScheme
            //                                     .primary,
            //                               ),
            //                             ),
            //                             Text(
            //                               EvC.DataKategoriEvents[index]
            //                                   ['tempat'],
            //                               style: TextStyle(
            //                                 color: Theme.of(context)
            //                                     .colorScheme
            //                                     .primary,
            //                               ),
            //                             ),
            //                           ],
            //                         )
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),




            // Obx(
            //   () => Column(
            //     children: List.generate(
            //       EvC.dataKategoriEvents.length,
            //       (index) {
            //         final DataKategoriEvent eventData =
            //             EvC.dataKategoriEvents[index];

            //         return InkWell(
            //           onTap: () {
            //             EvC.GetDetailEvent("${eventData.id}").then(
            //               (value) => Get.to(() => Details()),
            //             );
            //           },
            //           child: Card(
            //             elevation: 3,
            //             margin: EdgeInsets.all(10),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Image.network(
            //                   eventData.getBannerUrl(),
            //                   height: 150,
            //                   width: double.infinity,
            //                   fit: BoxFit.cover,
            //                 ),
            //                 Padding(
            //                   padding: EdgeInsets.all(10),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         eventData.namaEvent,
            //                         style: TextStyle(
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: 16,
            //                           color:
            //                               Theme.of(context).colorScheme.primary,
            //                         ),
            //                       ),
            //                       Text(
            //                         eventData.deskripsi,
            //                         style: TextStyle(
            //                           color:
            //                               Theme.of(context).colorScheme.primary,
            //                         ),
            //                       ),
            //                       SizedBox(height: 15),
            //                       Row(
            //                         children: [
            //                           Image.network(
            //                             EvC.getBannerUrl(
            //                                 eventData.id, eventData.banner),
            //                             width: 30,
            //                             height: 30,
            //                           ),
            //                           SizedBox(width: 10),
            //                           Column(
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               Text(
            //                                 eventData.penyelenggara[
            //                                     'nama_penyelenggara'],
            //                                 style: TextStyle(
            //                                   color: Theme.of(context)
            //                                       .colorScheme
            //                                       .primary,
            //                                 ),
            //                               ),
            //                               Text(
            //                                 eventData.tempat,
            //                                 style: TextStyle(
            //                                   color: Theme.of(context)
            //                                       .colorScheme
            //                                       .primary,
            //                                 ),
            //                               ),
            //                             ],
            //                           )
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),


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

                        // InkWell(
                        //   onTap: () {
                        //   },
                        //   child: Obx(
                        //     () => Container(
                        //       // height: 50,
                        //       padding: const EdgeInsets.all(15),
                        //       decoration: BoxDecoration(
                        //         color: const Color(0xfff2f2f2),
                        //         border: Border.all(
                        //           color: Colors.transparent,
                        //           width: 0,
                        //         ),
                        //         borderRadius: BorderRadius.circular(15),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color:
                        //                 const Color.fromARGB(255, 192, 187, 187)
                        //                     .withOpacity(1),
                        //             offset: const Offset(0, 5),
                        //             blurRadius: 3,
                        //             spreadRadius: -4,
                        //           ),
                        //         ],
                        //       ),
                        //       child: evC.isLoading.value
                        //           ? ShimmerCategoryCard()
                        //           : Row(
                        //               children: [
                        //                 Icon(
                        //                   Icons.abc,
                        //                   color: const Color(0XFF1E2126),
                        //                   size: 17,
                        //                 ),
                        //                 const SizedBox(width: 10),
                        //                 Text(
                        //                   'test',
                        //                   style: TextStyle(
                        //                     color: Theme.of(context)
                        //                         .colorScheme
                        //                         .tertiary,
                        //                     fontWeight: FontWeight.w300,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //     ),
                        //   ),
                        // ),
