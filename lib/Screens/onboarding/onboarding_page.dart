import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_flutter_demo/Constants/app_constants.dart';
import 'package:movie_flutter_demo/Constants/app_string_constant.dart';
import 'package:movie_flutter_demo/Helper/CommonButton.dart';
import 'package:movie_flutter_demo/Helper/ImageView.dart';

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
            const Text(AppStrings.entertainment,textAlign: TextAlign.center,
              style: TextStyle(fontSize: AppFontSize.extraLarge,
                  fontWeight: FontWeight.w900, ),),
            _spacing(),
            const Text(AppStrings.onboarding,
              style: TextStyle(fontSize: AppFontSize.large,
                  fontWeight: FontWeight.w600),),
            _spacing(),
            AppElevatedButton( AppStrings.getStarted, () {
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
            ImageView(asset: AppImages.moviePoster,height: double.infinity,),
            Positioned(
                child: Container(
                  color: Colors.black.withAlpha(120),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SafeArea(
                          child: ImageView(asset: AppImages.logo,height: AppIconSize.logo,width: AppIconSize.logo,)),
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
