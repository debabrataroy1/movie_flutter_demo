import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_size_constants.dart';
import 'package:movie_flutter_demo/Constants/border_radius_constants.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Helper/image_view.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/WishlistButton/wishlist_button_cubit.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/WishlistButton/wishlist_button_widget.dart';
import 'package:movie_flutter_demo/Constants/icons_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';

class MovieBanner extends StatelessWidget {
  final MovieData movie;
 const MovieBanner(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Hero(
              tag: movie.id.toString(),
              child: ImageView(url: ServerConstants.imageBaseUrl + (movie.imageUrl ?? ''))),
          Positioned(
              right: AppSpacing.mini,
              top: AppSpacing.extraLarge,
              child: InkWell(
                  onTap: () { },
                  child: Container(
                      width: ContanierSize.regular,
                      height: ContanierSize.regular,
                      padding: const EdgeInsets.all(AppPaddings.mini),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppBorderRadius.large))
                      ),
                      child: const Center(
                          child: Icon(
                              AppIcons.share,
                              size: AppIconSize.large,
                              color: AppColors.primaryColor))
                  )
              )
          ),
          Positioned(
              right: AppSpacing.mini,
              top: AppSpacing.mini,
              child: BlocProvider(
                  create: (context) => WishListCubit(),
                  child: WishListButtonWidget(movie: movie)
              )
          )
        ]);
  }
}
