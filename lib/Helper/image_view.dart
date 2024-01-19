import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/gen/assets.gen.dart';

class ImageView extends StatelessWidget {
  String? url;
  double height;
  double width;
  BoxFit fit;
  ImageView({Key? key, this.url, this.width = 0.0, this.height = 0.0,this.fit= BoxFit.cover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
        placeholder: AssetImage(Assets.images.placeholder.path),
        image: NetworkImage(url ?? ''),
        imageErrorBuilder:(context, error, stackTrace) {
          return Assets.images.placeholder.image(
              width: width != 0.0 ?  width : null,
              height:  height != 0.0 ?  height : null);
        },
        fit: fit,
        width:  width != 0.0 ?  width : null,
        height: height != 0.0 ?  height : null

    );
  }
}