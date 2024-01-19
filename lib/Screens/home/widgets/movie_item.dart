import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/app_size_constants.dart';
import 'package:movie_flutter_demo/Constants/border_radius_constants.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Helper/image_view.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Routes/app_router_config.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/WishlistButton/wishList_button_cubit.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/WishlistButton/wishlist_button_widget.dart';

class MovieItem extends StatelessWidget {
  final MovieData movie;
  late bool isWishlist;
  Function(int,bool)? wishListAction;
  ValueNotifier<bool> _wishlist = ValueNotifier<bool>(false);

  MovieItem(this.movie, {super.key, this.wishListAction, this.isWishlist = false}) {
    _wishlist.value = isWishlist;
  }
  final double _itemWidth = (AppSize.width / 2);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: AppPaddings.extraSmall),
        child: InkWell(
          onTap: () {
            DetailRoute((movie, isWishlist,(id, value){
             if (value != isWishlist) {
               isWishlist = value;
               _wishlist.value = isWishlist;
               if (wishListAction != null) {
               wishListAction!(id, value);
               }
             }
           })).push(context);
          },
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
                          child: Hero(
                              tag: movie.id.toString(),
                              child:ImageView(url: ServerConstants.imageBaseUrl + (movie.imageUrl ?? ''),
                              height: _itemWidth - 55, width: _itemWidth
                          ))),
                      Positioned(
                          right: 4,
                          top: 4,
                          child: BlocProvider(create: (context) => WishListCubit(),
                              child:ValueListenableBuilder(
                                  valueListenable: _wishlist,
                                  builder: (context, value, _) {
                                    return WishListButtonWidget(movie: movie, isWishlist: isWishlist, wishListAction: (id, value){
                                      isWishlist = value;
                                      if (wishListAction != null) {
                                        wishListAction!(id, value);
                                      }
                                    });
                                  }
                              ) )
                      ),
                      Positioned(
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
                      )
                    ]),
                    Expanded(
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
                    )
                  ])
          ),
        )
    );
  }
}
