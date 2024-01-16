import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Utils/DBManager.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'package:movie_flutter_demo/Screens/home/repository/home_repository.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/state/home_bloc_state.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/event/home_bloc_event.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeRepository? repository;
  HomeResponse? carouselData;
  List<MovieData> homeListData = [];
  int pageNo = 2;
  bool isLoading = false;

  HomeBloc({this.repository}) : super(HomeInitialState()) {
    mapEventToState(FetchCarouselDataEvent());
    mapEventToState(HomeFetchDataEvent());
  }

  void mapEventToState(HomeBlocEvent event) async {
    try {
      HomeResponse? model;
      if( event is HomeFetchDataEvent) {
        isLoading = true;
        emit(HomeLoadMoreState(true));
        model = await repository?.getHomeData(pageNo);
      } else {
        List<int> ids = await AppInjector.getIt<DBManager>().getAllIds();
        emit(AllWishListState(ids));
        model = await repository?.getHomeData(1);
      }
      if (model != null) {
        if( event is FetchCarouselDataEvent) {
          carouselData = model;
          emit(HomeCarouselSuccessState());
        } else {
          homeListData.addAll( model.results ?? []);
          pageNo++;
          emit(HomeListSuccessState());
          emit(HomeLoadMoreState(false));
        }
      } else {
        emit(HomeError(''));
      }
      isLoading = false;
    } catch (error, _) {
      emit(HomeError(error.toString()));
      isLoading = false;
    }
  }
}
