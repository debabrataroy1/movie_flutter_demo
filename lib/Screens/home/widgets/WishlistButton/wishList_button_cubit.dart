import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/WishlistButton/wishlist_cubit_state.dart';
import 'package:movie_flutter_demo/Utils/db_manager.dart';
import 'package:movie_flutter_demo/di/injector.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit() : super(WishListInitState());

  void reloadUI() {
    emit(WishListInitState());
  }

  void addRemoveWishlist(BuildContext context, MovieData movie, {bool isNeedToAdd = true}) async {
    var db = AppInjector.getIt<DBManager>();
    if (isNeedToAdd) {
      var result = await db.insert(movie);
      if (result > 0) {
        if (context.mounted) emit(WishListSuccess(context.l10n.successfullyAdd));
      } else {
        if (context.mounted) emit(WishListError(context.l10n.dbError));
      }
    } else {
      var result = await db.delete(movie.id ?? 0);
      if (result > 0) {
        if (context.mounted) {
          emit(WishListSuccess(context.l10n.successfullyRemoved));
        }

      } else {
        if (context.mounted)  emit(WishListError(context.l10n.dbError));
      }
    }
  }
}