
import 'dart:ffi';

import 'package:movie_flutter_demo/Models/home_model.dart';

abstract class HomeBlocEvent {

  @override
  List<Object> get props => [];
}

class FetchCarouselDataEvent extends HomeBlocEvent {
   FetchCarouselDataEvent();

  @override
  List<Object> get props => [];
}

class HomeFetchDataEvent extends HomeBlocEvent {
  HomeFetchDataEvent();

  @override
  List<Object> get props => [];
}