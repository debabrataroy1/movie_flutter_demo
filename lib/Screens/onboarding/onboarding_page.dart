import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_flutter_demo/gen/assets.gen.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Helper/CommonButton.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  Widget _spacing() {
    return const SizedBox(height: AppSpacing.regular,);
  }
  Widget _bottom(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: AppPaddings.regular, right: AppPaddings.regular),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [AppColors.primaryColor.withAlpha(50),
                AppColors.primaryColor.withAlpha(0)]
          )),
      child: SafeArea(
        child:  Column(
          children: [
            _spacing(),
             Text(context.l10n.entertainment,textAlign: TextAlign.center,
              style: const TextStyle(fontSize: AppFontSize.extraLarge,
                  fontWeight: FontWeight.w900, ),),
            _spacing(),
             Text(context.l10n.onboarding,
              style: const TextStyle(fontSize: AppFontSize.large,
                  fontWeight: FontWeight.w600),),
            _spacing(),
            AppElevatedButton(title: context.l10n.getStarted,onPressed:  () {
              context.go('/login');
            })
          ],),
      ),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Stack(
          children: [
            Assets.images.moviePoster.image(height: double.infinity, fit: BoxFit.fill),
            Positioned(
                child: Container(
                  color: Colors.black.withAlpha(120),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SafeArea(
                          child:Assets.images.logo.image(height: AppIconSize.logo, width: AppIconSize.logo)
                      ),
                      const Spacer(),
                      _bottom(context)
                    ],
                  ),
                )
            )
          ],
        )
    );
  }
}
