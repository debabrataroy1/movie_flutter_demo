import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Screens/favourites/cubit/state/favourite_state.dart';
import 'package:movie_flutter_demo/Utils/db_manager.dart';
import 'package:movie_flutter_demo/di/injector.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitState()) {
    getWishlist();
  }

  void getWishlist() async {
    var db = AppInjector.getIt<DBManager>();
    var result = await db.queryAllMovies();
    emit(AllWishListState(result));
  }
}