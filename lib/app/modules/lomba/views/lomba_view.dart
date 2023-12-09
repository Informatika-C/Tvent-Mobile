import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lomba_controller.dart';

class LombaView extends GetView<LombaController> {
  const LombaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LombaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LombaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
