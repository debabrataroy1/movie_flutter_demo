import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/border_radius_constants.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'dart:io';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';
import 'package:movie_flutter_demo/gen/assets.gen.dart';

class ProfileImageWidget extends StatelessWidget {
  final String gender;
  final File? pickedImage;
  const ProfileImageWidget(this.gender, {super.key, this.pickedImage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: AppIconSize.logo,
          height: AppIconSize.logo,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withAlpha(100), // Change color of the shadow
                blurRadius: AppBorderRadius.extraLarge,
                spreadRadius: AppBorderRadius.small,
              )],
            border: Border.all(
                color: AppColors.primaryColor,
                width: 2.0
            ),
            borderRadius: BorderRadius.circular(AppBorderRadius.extraLarge),
          ),
          child:  pickedImage != null ?
          ClipRRect(borderRadius: BorderRadius.circular(AppBorderRadius.extraLarge),
              child: Image.file(pickedImage!, fit: BoxFit.cover,
                  height: AppIconSize.logo, width: AppIconSize.logo))
              : gender == AppLocalization.instance.keys.other ? Assets.images.other.image()
              : gender == AppLocalization.instance.keys.female ? Assets.images.woman.image()
              : Assets.images.man.image()
      )
    );
  }
}
