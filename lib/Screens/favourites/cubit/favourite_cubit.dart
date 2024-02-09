import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Screens/favourites/cubit/state/favourite_state.dart';
import 'package:movie_flutter_demo/Utils/db_manager.dart';
import 'package:movie_flutter_demo/di/injector.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final DBManager? _dbManager;
  FavouriteCubit({DBManager? dbManager}) : _dbManager = dbManager ?? AppInjector.getIt<DBManager>(), super(FavouriteInitState()) {
    getWishlist();
  }

  void getWishlist() async {
    var result = await _dbManager?.queryAllMovies() ?? [];
    emit(AllWishListState(result));
  }
}