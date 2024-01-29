import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/WishlistButton/wishlist_cubit_state.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';
import 'package:movie_flutter_demo/Utils/db_manager.dart';
import 'package:movie_flutter_demo/di/injector.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit({DBManager? dbManager}) : _dbManager = dbManager ?? AppInjector.getIt<DBManager>(),
        super(WishListInitState());
  final DBManager _dbManager;

  void addRemoveWishlist(MovieData movie, ) async {
    if (!movie.isFavourite) {
      var result = await _dbManager.insert(movie);
      (result > 0) ?
      emit(WishListSuccess(AppLocalization.instance.keys.successfullyAdd))
          : emit(WishListError(AppLocalization.instance.keys.dbError));
    } else {
      var result = await _dbManager.delete(movie.id ?? 0);
      (result > 0) ?
      emit(WishListSuccess(AppLocalization.instance.keys.successfullyRemoved))
          : emit(WishListError(AppLocalization.instance.keys.dbError));
    }
  }
}