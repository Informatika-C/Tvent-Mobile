import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/about/views/video_widget.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  AboutView({super.key});

  @override
  final controller = Get.put(AboutController());
  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('What Tvent is?'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome To Tvent',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.grey[300],
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayerWidget(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Explore Campus Events with Ease! Tvent is an exclusive platform for exploring and registering for vibrant campus events. Specifically designed to make it easier for you to plan and attend every meeting, exhibition, and campus activity.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16.0,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    "Key Features of TVENT:",
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5.0),
                  _buildDescriptionList(iconColor),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Tvent is created to enrich your campus experience. Make Tvent your loyal companion in navigating your campus life. Join now and capture precious moments at every step! Tvent: Discover Campus, Discover Moments!',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16.0,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 100),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(
                        Theme.of(context).brightness == Brightness.dark
                            ? "assets/images/tventLight.png"
                            : "assets/images/tventDark.png",
                        width: 120,
                        height: 120,
                      ),
                    ),
                    Text(
                      "©2023 CONST - All Rights Reserved",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionList(Color iconColor) {
    List<Map<String, dynamic>> dataList = [
      {
        "text":
            "Simplified Event Registration: Register and join your favorite campus events with simple and quick registration steps.",
        "icon": getFontAwesomeIcon(1)
      },
      {
        "text":
            "Explore Campus Activities: Discover various campus activities that align with your interests and hobbies. Explore the campus event agenda with just a few clicks.",
        "icon": getFontAwesomeIcon(2)
      },
      {
        "text":
            "Solid Student Community: Join a solid student community, share experiences, and make peer friends with similar interests.",
        "icon": getFontAwesomeIcon(3)
      },
      {
        "text":
            "Latest Campus News: Stay informed with the latest news and information about campus life. Gain insights from the newest activities and events.",
        "icon": getFontAwesomeIcon(4)
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: dataList
          .map(
            (data) => _buildListItem(data["text"], data["icon"], iconColor),
          )
          .toList(),
    );
  }

  Widget _buildListItem(String text, IconData iconData, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            size: 13,
            color: iconColor,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  IconData getFontAwesomeIcon(int number) {
    switch (number) {
      case 1:
        return FontAwesomeIcons.one;
      case 2:
        return FontAwesomeIcons.two;
      case 3:
        return FontAwesomeIcons.three;
      case 4:
        return FontAwesomeIcons.four;
      default:
        return FontAwesomeIcons.question;
    }
  }
}
