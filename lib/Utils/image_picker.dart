import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'dart:io';
import 'package:movie_flutter_demo/Helper/CommonButton.dart';

class AppImagePicker {
  final BuildContext context;
  final ValueChanged<File>? pickerImage;

  AppImagePicker(this.context,{this.pickerImage});

  void show() {
    _imagePicker();
  }

  void _imagePicker() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(context.l10n.chooseImage),
        actions: [
      AppElevatedButton(
            title: context.l10n.camera,
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          AppElevatedButton(
            title:context.l10n.gallery,
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          )
        ])
    ).then((ImageSource? source) async {
      if (source == null) return;
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) return;
      if (pickerImage != null) {
        pickerImage!(File(pickedFile.path));
      }
    });
  }
}
