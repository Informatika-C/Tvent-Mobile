import 'dart:io'; // Import the 'dart:io' library for File class
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  Map<String, dynamic> pickedImage = {};

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File pickedImageFile = File(pickedFile.path);

      // Check image size
      int maxSizeInBytes = 5 * 1024 * 1024; // 5 MB (adjust as needed)

      if (pickedImageFile.lengthSync() > maxSizeInBytes) {
        // Display an error or inform the user about the size limit
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Image size exceeds the limit of 5 MB.',
          textConfirm: 'OK',
          onConfirm: () => Get.back(),
        );
        return;
      }

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        maxHeight: 500,
        maxWidth: 500,
      );

      if (croppedFile != null) {
        setState(() {
          pickedImage = {
            "image_path": croppedFile.path,
          };
        });
        print(pickedImage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker and Cropper Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pickedImage.isNotEmpty)
              Image.file(
                File(pickedImage["image_path"]), // Create a File object
                height: 200,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Select Image'),
            ),
          ],
        ),
      ),
    );
  }
}
