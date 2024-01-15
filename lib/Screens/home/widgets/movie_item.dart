import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/app_size_constants.dart';
import 'package:movie_flutter_demo/Constants/border_radius_constants.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icons_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Helper/ImageView.dart';
import '../../../Constants/api_constants.dart';
import '../../../Models/home_model.dart';

class MovieItem extends StatelessWidget {
  MovieData movie;
  MovieItem(this.movie, {super.key});
  final double _itemWidth = (AppSize.width / 2);

  Widget _favouriteButton() {
    return Positioned(
        right: 4,
        top: 4,
        child: Container(
            width: ContanierSize.regular,
            height: ContanierSize.regular,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.all(Radius.circular(AppBorderRadius.large))
            ),
            child: const Center(
                child: Icon(
                    AppIcons.favouriteFill,
                    size: AppIconSize.large, color: Colors.grey)
            )
        )
    );
  }

  Widget _languageContaner(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: Container(
            padding: const EdgeInsets.all(AppPaddings.extraSmall),
            width: _itemWidth - 12,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withAlpha(200),
                      Colors.black.withAlpha(0)]
                )),
            child: Row(
                children: [
                  Text((movie.adult ?? false) ? context.l10n.adult : context.l10n.ua, style: const TextStyle(color: AppColors.whiteTextColor)),
                  const Spacer(),
                  Text(movie.language ?? '', style: const TextStyle(color: AppColors.whiteTextColor))
                ])
        )
    );
  }

  Widget _titleWidget() {
    return Expanded(
        flex: 1,
        child: Padding(
            padding: const EdgeInsets.all(AppPaddings.extraSmall),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: Text(
                          movie.title ?? '',
                          style: const TextStyle(fontSize: AppFontSize.regular,
                              fontWeight: FontWeight.w600), maxLines: 2)
                  )
                ])
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: AppPaddings.extraSmall),
        child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(AppBorderRadius.regular))
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(AppBorderRadius.regular),
                          topLeft: Radius.circular(AppBorderRadius.regular),
                        ),
                        child: ImageView(url: ServerConstants.imageBaseUrl + (movie.imageUrl ?? ''),
                            height: _itemWidth - 55, width: _itemWidth
                        )),
                    _favouriteButton(),
                    _languageContaner(context),
                  ]),
                  _titleWidget()
                ])
        )
    );
  }
}
