import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/border_radius_constants.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Helper/ImageView.dart';
import '../../../Constants/api_constants.dart';
import '../../../Models/home_model.dart';

class MovieItem extends StatefulWidget {
  MovieData movie;
  MovieItem(this.movie, {super.key});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: AppPaddings.extraSmall),
        child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(AppBorderRadius.regular))
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: ImageView(url: ServerConstants.imageBaseUrl + (widget.movie.imageUrl ?? ''),
                        height: AppIconSize.logo, width: AppIconSize.logo,
                      )),
                  Expanded(
                      flex: 1,
                      child: Padding(
                          padding: const EdgeInsets.all(AppPaddings.extraSmall),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                            widget.movie?.title ?? '',
                                            style: const TextStyle(fontSize: AppFontSize.regular,
                                                fontWeight: FontWeight.w600), maxLines: 2
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.medium),
                                      Container(
                                          width: 30,
                                          height: 30,
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius: const BorderRadius.all(Radius.circular(22))
                                          ),
                                          child: const Center(
                                              child: Icon(
                                                  Icons.favorite,
                                                  size: 20, color: Colors.grey
                                              )
                                          )
                                      )
                                    ]),
                                Text((widget.movie.adult ?? false) ? "Adult" : "UA"),
                                Text(widget.movie.language ?? '')
                              ])
                      )
                  )
                ])
        )
    );
  }
}
