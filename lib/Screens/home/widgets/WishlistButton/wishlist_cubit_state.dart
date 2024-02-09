
abstract class WishListState {}

class WishListInitState extends WishListState { }

class WishListSuccess extends WishListState {
  WishListSuccess(this.message);
  final String message;
}
class WishListError extends WishListState {
  WishListError(this.message);
   final String message;
}