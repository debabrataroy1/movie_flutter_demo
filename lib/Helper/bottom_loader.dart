import 'package:movie_flutter_demo/Constants/app_size_constants.dart';
import 'package:movie_flutter_demo/Helper/app_loader.dart';
import 'package:flutter/material.dart';
class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: ContanierSize.medium,
        child: AppLoader()
    );
  }
}
