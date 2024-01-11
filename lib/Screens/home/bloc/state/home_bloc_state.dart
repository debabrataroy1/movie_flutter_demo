
abstract class HomeBlocState {
  const HomeBlocState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeBlocState { }

class HomeLoadingState extends HomeBlocState { }

class HomeLoadMoreState extends HomeBlocState {
  HomeLoadMoreState(this.isLoadMore);
  bool? isLoadMore;
}

class HomeCarouselSuccessState extends HomeBlocState {
  HomeCarouselSuccessState();
}

class HomeListSuccessState extends HomeBlocState { }

class HomeError extends HomeBlocState {
  HomeError(this.message);
  String? message;
}
