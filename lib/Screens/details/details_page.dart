import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_size_constants.dart';
import 'package:movie_flutter_demo/Constants/border_radius_constants.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Helper/ImageView.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/WishlistButton/wishList_button_cubit.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/WishlistButton/wishlist_button_widget.dart';
import 'package:movie_flutter_demo/Constants/icons_constants.dart';

class DetailPage extends StatelessWidget {
  final (MovieData,bool,Function(int,bool)?) movie;
  const DetailPage(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(movie.$1.title ?? ''),centerTitle: false,),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              Stack(
                  children: [
                    Hero(
                        tag: movie.$1.id.toString(),
                        child: ImageView(url: ServerConstants.imageBaseUrl + (movie.$1.imageUrl ?? ''))),
                    Positioned(
                        right: 4,
                        top: 44,
                        child: InkWell(
                            onTap: () {

                            },
                            child: Container(
                                width: ContanierSize.regular,
                                height: ContanierSize.regular,
                                padding: const EdgeInsets.all(3),
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
                        right: 4,
                        top: 4,
                        child: BlocProvider(
                            create: (context) => WishListCubit(),
                            child: WishListButtonWidget(movie: movie.$1, isWishlist: movie.$2, wishListAction:movie.$3)
                        )
                    )
                  ]),
              Padding(
                  padding: const EdgeInsets.all(AppSpacing.medium),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: ImageView(url: ServerConstants.imageBaseUrl + (movie.$1.poster ?? ''), height: 100,width: 80,
                                  fit: BoxFit.fill,
                                )),
                            const SizedBox(width: AppSpacing.medium),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: AppSize.width - 130,
                                    child: Text(movie.$1.title ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                                const SizedBox(height: AppSpacing.extraSmall),
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: AppPaddings.small),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.red
                                            ),
                                            borderRadius: const BorderRadius.all(Radius.circular(AppBorderRadius.large))
                                        ),
                                        child: Text(movie.$1.language ?? '')
                                    ),
                                    const SizedBox(width: AppSpacing.extraSmall),
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: AppPaddings.small),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.red
                                            ),
                                            borderRadius: const BorderRadius.all(Radius.circular(AppBorderRadius.large))
                                        ),
                                        child: Text((movie.$1.adult ?? false) ? context.l10n.adult : context.l10n.ua)
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.mini),
                                Text("Release date: ${movie.$1.releaseDate ?? ''}"),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(children: [
                          Expanded(
                              child: Column(children: [
                                Text(movie.$1.popularity.toString() ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                const Text('IMDB'),
                                const Text('themoviedb.org')
                              ],)),
                          Expanded(
                              child: Column(children: [
                                const Icon(Icons.star,color: Color(0xffffa534)),
                                Text(movie.$1.voteAverage?.roundToDouble().toString() ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(movie.$1.voteCount.toString() ?? ''),
                              ])),
                        ]),
                        const Divider(),
                        const Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: AppSpacing.extraSmall),
                        Text(movie.$1.overview ??'')
                      ] )
              )
            ])
        )
    );
  }
}
