import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_size_constants.dart';
import 'package:movie_flutter_demo/Constants/border_radius_constants.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Helper/image_view.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
class MovieReviewWidget extends StatelessWidget {
  final MovieData movie;
  const MovieReviewWidget(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(AppBorderRadius.regular),
            child: ImageView(url: ServerConstants.imageBaseUrl + (movie.poster ?? ''), height: AppIconSize.logo,width: AppIconSize.logo - 20,
              fit: BoxFit.fill,
            )),
        const SizedBox(width: AppSpacing.medium),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: AppSize.width - 130,
                child: Text(movie.title ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSize.large))),
            const SizedBox(height: AppSpacing.extraSmall),
            Row(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppPaddings.small),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: AppColors.primaryColor
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(AppBorderRadius.large))
                      ),
                      child: Text(movie.language ?? '')
                  ),
                  const SizedBox(width: AppSpacing.extraSmall),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppPaddings.small),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: AppColors.primaryColor
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(AppBorderRadius.large))
                      ),
                      child: Text((movie.adult ?? false) ? context.l10n.adult : context.l10n.ua)
                  ),
                ]),
            const SizedBox(height: AppSpacing.mini),
            Text("${context.l10n.releaseData}${movie.releaseDate ?? ''}")
          ])
      ]);
  }
}
