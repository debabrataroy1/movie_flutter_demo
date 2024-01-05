import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/app_constants.dart';

class ImageView extends StatelessWidget {
  String? url;
  String? asset;
  double height;
  double width;
  BoxFit fit;
  ImageView({Key? key, this.url,this.asset, this.width = 0.0, this.height = 0.0,this.fit= BoxFit.fill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
        placeholder: const AssetImage(AppImages.placeholder),
        image: ((asset != null) ? AssetImage(asset!) : NetworkImage(url ?? '')) as ImageProvider,
        imageErrorBuilder:(context, error, stackTrace) {
          return Image.asset(AppImages.placeholder,
              width: width != 0.0 ?  width : null,
              height:  height != 0.0 ?  height : null);
        },
        fit: fit,
        width:  width != 0.0 ?  width : null,
        height: height != 0.0 ?  height : null
    );
  }
}