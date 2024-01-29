import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Screens/details/widgets/movie_banner_widget.dart';
import 'package:movie_flutter_demo/Screens/details/widgets/movie_review_widget.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';

class DetailPage extends StatelessWidget {
  final MovieData movie;
  const DetailPage(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(movie.title ?? ''), centerTitle: false),
        body: SingleChildScrollView(
            child: Column(children: [
              MovieBanner(movie),
              Padding(
                  padding: const EdgeInsets.all(AppSpacing.medium),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MovieReviewWidget(movie),
                        const SizedBox(height: AppSpacing.mini),
                        const Divider(),
                        Row(children: [
                          Expanded(
                              child: Column(children: [
                                Text(movie.popularity.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSize.regular)),
                                const Text('IMDB'),
                                const Text('themoviedb.org')
                              ])),
                          Expanded(
                              child: Column(children: [
                                const Icon(Icons.star, color: AppColors.ratingColor),
                                Text(movie.voteAverage?.roundToDouble().toString() ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSize.regular)),
                                Text(movie.voteCount.toString())
                              ]))
                        ]),
                        const Divider(),
                         Text(AppLocalization.instance.keys.description, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSize.regular)),
                        const SizedBox(height: AppSpacing.extraSmall),
                        Text(movie.overview ??'')
                      ])
              )
            ])
        )
    );
  }
}
