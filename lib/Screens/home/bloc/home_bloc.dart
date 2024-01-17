import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Utils/db_manager.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'package:movie_flutter_demo/Screens/home/repository/home_repository.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/state/home_bloc_state.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/event/home_bloc_event.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeRepository? repository;
  int totalPages = 0;
  List<MovieData> homeListData = [];
  List<MovieData> homeCarouselData = [];
  int pageNo = 2;

  HomeBloc({this.repository}) : super(HomeInitialState()) {
    mapEventToState(FetchCarouselDataEvent());
    mapEventToState(HomeFetchDataEvent());
  }

  void mapEventToState(HomeBlocEvent event) async {
    try {
      HomeResponse? model;
      if( event is HomeFetchDataEvent) {
        model = await repository?.getHomeData(pageNo);
      } else {
        List<int> ids = await AppInjector.getIt<DBManager>().getAllIds();
        emit(AllWishListState(ids));
        model = await repository?.getHomeData(1);
      }
      if (model != null) {
        if( event is FetchCarouselDataEvent) {
          totalPages = model.totalPages ?? 0;
          homeCarouselData = (((model.results?.length ?? 0) > 9) ? model.results?.getRange(0, 9).toList() : model.results) ?? [];
          emit(HomeCarouselSuccessState());
        } else {
          homeListData.addAll( model.results ?? []);
          pageNo++;
          emit(HomeListSuccessState());
        }
      } else {
        emit(HomeError(''));
      }
    } catch (error, _) {
      emit(HomeError(error.toString()));
    }
  }
}
