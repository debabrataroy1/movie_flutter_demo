import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/movie_item.dart';
class HomeMovieList extends StatelessWidget {
  final String title;
  final List<MovieData> movieList;
  final List<int>? wishListItems;
  Function(int,bool)? wishListAction;
  HomeMovieList(this.title, this.movieList, {super.key, this.wishListAction, this.wishListItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: AppPaddings.extraSmall, right: AppPaddings.extraSmall, top: AppPaddings.regular),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: AppFontSize.large,
                  fontWeight: FontWeight.w600)),
              const SizedBox(height: AppSpacing.extraSmall),
              GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.extraSmall,
                      mainAxisSpacing: AppSpacing.extraSmall,
                      childAspectRatio: 1
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var movie = movieList[index];
                    return MovieItem(movie, wishListAction: wishListAction, isWishlist: wishListItems?.contains(movie.id) ?? false,);
                  },
                  itemCount: (movieList.length)
              )
            ])
    );
  }
}
