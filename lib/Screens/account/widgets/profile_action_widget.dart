import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/icons_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';

class ProfileActionWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final GestureTapCallback? onTap;
  const ProfileActionWidget(this.label,this.icon, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(padding: const EdgeInsets.all(AppPaddings.extraSmall),
          child:
          Row(children: [
            Icon(icon),
            const SizedBox(width: AppSpacing.extraSmall),
            Text(label),
            const Spacer(),
            const Icon(AppIcons.arrow)
          ])
      )
    );
  }
}
