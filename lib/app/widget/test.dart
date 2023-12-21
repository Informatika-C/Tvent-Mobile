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