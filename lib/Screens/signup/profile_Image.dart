import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/border_radius_constants.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icons_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';
import 'package:movie_flutter_demo/Utils/image_picker.dart';
import 'package:movie_flutter_demo/gen/assets.gen.dart';
import 'dart:io';
// ignore: must_be_immutable
class ProfileImage extends StatefulWidget {
  final ValueChanged<File>? pickerImage;
  final String? gender;
  File? pickedImage;
  ProfileImage({this.pickerImage,this.pickedImage, this.gender, super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Padding(
              padding: const EdgeInsets.all(AppPaddings.extraSmall),
              child: Container(
                  width: AppIconSize.logo,
                  height: AppIconSize.logo,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2.0
                    ),
                    borderRadius: BorderRadius.circular(AppBorderRadius.extraLarge),
                  ),
                  child:  widget.pickedImage != null ?
                  ClipRRect(borderRadius: BorderRadius.circular(AppBorderRadius.extraLarge),
                      child: Image.file(widget.pickedImage!, fit: BoxFit.cover,
                          height: AppIconSize.logo, width: AppIconSize.logo))
                      : widget.gender == AppLocalization.instance.keys.other ? Assets.images.other.image()
                      : widget.gender == AppLocalization.instance.keys.female ? Assets.images.woman.image()
                      : Assets.images.man.image())
          ),
          Positioned(
              right: 0,
              top: 60,
              child: InkWell(
                  onTap:(){
                    AppImagePicker(context, pickerImage:(image) {
                      setState(() {
                        widget.pickedImage = image;
                      });
                      if (widget.pickerImage != null && widget.pickedImage != null) {
                        widget.pickerImage!(widget.pickedImage!);
                      }
                    }).show();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(AppPaddings.mini),
                      decoration: BoxDecoration(
                        color: AppColors.whiteTextColor,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                      ),
                      child: const Icon(AppIcons.edit, color:AppColors.primaryColor, size: AppIconSize.large)
                  )
              )
          )
        ]);
  }

}
