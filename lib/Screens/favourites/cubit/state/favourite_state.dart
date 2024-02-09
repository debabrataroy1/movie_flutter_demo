import 'package:movie_flutter_demo/Models/home_model.dart';

abstract class FavouriteState {
  const FavouriteState();
}

class FavouriteInitState extends FavouriteState { }

class AllWishListState extends FavouriteState {
  AllWishListState(this.wishListItems);
  final List<MovieData> wishListItems;
}