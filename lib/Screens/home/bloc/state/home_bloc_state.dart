
import 'package:movie_flutter_demo/Models/home_model.dart';

abstract class HomeBlocState {
  const HomeBlocState();
}

class HomeInitialState extends HomeBlocState { }

class HomeCarouselSuccessState extends HomeBlocState {
  HomeCarouselSuccessState(this.carouselData);
  final List<MovieData> carouselData;
}

class HomeListSuccessState extends HomeBlocState {
  HomeListSuccessState(this.listData);
  final List<MovieData> listData;
}

class HomeError extends HomeBlocState {
  HomeError(this.message);
  String? message;
}
