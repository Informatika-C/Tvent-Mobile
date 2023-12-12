import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          buildParallaxSliver(screenHeight, context),
          buildImageList(),
        ],
      ),
    );
  }

  Widget buildParallaxSliver(double screenHeight, BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      expandedHeight: screenHeight * 1,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: Theme.of(context).colorScheme.background,
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Hi!',
                    textStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 24.0,
                    ),
                    speed: const Duration(milliseconds: 500),
                    curve: Curves.linear,
                  ),
                  TyperAnimatedText(
                    'Joint With Us',
                    textStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w900,
                    ),
                    speed: const Duration(milliseconds: 300),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
          ),
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Hi! Welcome ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: 'Admin',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    height: 0,
                  ),
                ),
              ],
            ),
          )),
      bottom: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height - screenHeight),
        child: Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: Text(
            'Additional Content',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return buildImageItem(index);
        },
        childCount: 20,
      ),
    );
  }

  Widget buildImageItem(int index) {
    String imageUrl = 'https://example.com/image_$index.jpg';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text('Item $index'),
          leading: Image.network(
            imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          onTap: () {
            // Tambahkan aksi atau navigasi saat item diklik
          },
        ),
      ),
    );
  }
}
