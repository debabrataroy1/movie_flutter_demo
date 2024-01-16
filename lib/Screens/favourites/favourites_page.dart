import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/app_size_constants.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icons_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Screens/favourites/cubit/favourite_cubit.dart';
import 'package:movie_flutter_demo/Screens/favourites/cubit/state/favourite_state.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/home_movie_list.dart';

class FavouritesPage extends StatelessWidget {
  List<MovieData>? movieList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.favourites)),
        body:BlocBuilder<FavouriteCubit, FavouriteState>(
            builder: (context, state) {
              if (state is AllWishListState && state.wishListItems.isNotEmpty) {
                return SingleChildScrollView(
                    child: HomeMovieList(
                        context.l10n.myFavouriteList, state.wishListItems,
                        wishListItems: state.wishListItems.map((e) => (e.id ?? 0)).toList())
                );
              } else {
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: ContanierSize.extraLarge,
                              height: ContanierSize.extraLarge,
                              padding: const EdgeInsets.all(AppPaddings.extraSmall),
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withAlpha(100),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(60))
                              ),
                              child: Center(
                                  child: Icon(
                                      AppIcons.favouriteFill,
                                      size: AppIconSize.extraLarge,
                                      color: Theme.of(context).scaffoldBackgroundColor))
                          ),
                          const SizedBox(height: AppSpacing.regular),
                          Text(context.l10n.noFavouriteYet, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSize.large))
                        ])
                );
              }
            })
    );
  }
}
