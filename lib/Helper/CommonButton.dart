import 'package:flutter/cupertino.dart';// remove
import 'package:flutter/material.dart';

Widget AppTextButton(
    String text,
    VoidCallback onPressed,
    {
      Color? textColor,
      double? fontSize,
      FontWeight? fontWeight,
    }) {
  return TextButton(onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ));
}
Widget AppElevatedButton(
    String text,
    VoidCallback onPressed,
    ) {
  return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed,
          child: Text(
            text,
          )
      )
  );
}
