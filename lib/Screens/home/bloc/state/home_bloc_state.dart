
abstract class HomeBlocState {
  const HomeBlocState();
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeBlocState { }

class HomeCarouselSuccessState extends HomeBlocState {
  HomeCarouselSuccessState();
}

class HomeListSuccessState extends HomeBlocState { }

class HomeError extends HomeBlocState {
  HomeError(this.message);
  String? message;
}
