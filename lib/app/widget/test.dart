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