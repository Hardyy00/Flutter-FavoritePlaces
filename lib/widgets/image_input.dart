import 'dart:io';
import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.saveTheImage});

  final void Function(File) saveTheImage;
  @override
  State<ImageInput> createState() {
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<ImageInput> {
  File? selectedPicture;

  void _takeImage() async {
    final imagePicker = ImagePicker();

    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) return;

    widget.saveTheImage(File(pickedImage.path));

    setState(() {
      selectedPicture = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = TextButton.icon(
      onPressed: _takeImage,
      icon: const Icon(Icons.camera),
      label: const Text(
        "Take Picture",
        style: TextStyle(fontSize: 18),
      ),
    );

    if (selectedPicture != null) {
      mainContent = GestureDetector(
        onTap: _takeImage,
        child: Image.file(
          selectedPicture!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: mainContent,
    );
  }
}
