import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/border_radius_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';

class ProfileCardWidget extends StatelessWidget {
  final Widget child;
  const ProfileCardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(AppPaddings.extraSmall),
        child: Container(
            padding: const EdgeInsets.all(AppPaddings.extraSmall),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppBorderRadius.regular)
            ),
            child: child)
    );
  }
}

