import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  String title;
  VoidCallback? onPressed;
  Color? textColor;
  double? fontSize;
  FontWeight? fontWeight;

  AppTextButton({super.key, required this.title, this.onPressed, this.textColor, this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {

    return TextButton(onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor
          )
        )
    );
  }
}

class AppElevatedButton extends StatelessWidget {
   String title;
   VoidCallback? onPressed;

  AppElevatedButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(onPressed: onPressed,
            child: Text(
                title
            )
        )
    );
  }
}