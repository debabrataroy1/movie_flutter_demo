import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Utils/db_manager.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'package:movie_flutter_demo/Screens/home/repository/home_repository.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/state/home_bloc_state.dart';

class HomeCubit extends Cubit<HomeBlocState> {
  HomeRepository? repository;
  int totalPages = 0;
  List<MovieData> homeListData = [];
  List<MovieData> homeCarouselData = [];
  List<int> wishListIds = [];
  int pageNo = 2;
  final DBManager _dbManager;
  HomeCubit({this.repository, DBManager? dbManager}) : _dbManager = dbManager ?? AppInjector.getIt<DBManager>(), super(HomeInitialState()) {
    fetchWishListData();
    fetchCarouselData();
    getHomeData();
  }

  void fetchWishListData() async {
    wishListIds = await _dbManager.getAllIds();
  }

  void fetchCarouselData() async {
    try {
      HomeResponse? model = await repository?.getHomeData(1);
      if (model != null) {
        totalPages = model.totalPages ?? 0;
        homeCarouselData = (((model.results?.length ?? 0) > 9) ? model.results?.getRange(0, 9).toList() : model.results) ?? [];
        emit(HomeCarouselSuccessState());
      } else {
        emit(HomeError(''));
      }
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }

  void getHomeData() async {
    try {
      HomeResponse? model = await repository?.getHomeData(pageNo);
      if (model != null) {
        model.results?.forEach((element) {
          if (wishListIds.contains(element.id)) {
            element.isFavourite = true;
          }
        });
        homeListData.addAll(model.results ?? []);
        pageNo++;
        emit(HomeListSuccessState());
      } else {
        emit(HomeError(''));
      }
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }
}
