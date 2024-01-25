
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

class AllWishListState extends HomeBlocState {
  AllWishListState(this.wishListItems);
  final List<int> wishListItems;
}

class HomeError extends HomeBlocState {
  HomeError(this.message);
  String? message;
}
