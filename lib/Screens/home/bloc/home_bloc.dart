
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import '../repository/home_repository.dart';
import 'state/home_bloc_state.dart';
import 'event/home_bloc_event.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeRepository? repository;
  HomeResponse? carouselData;
  List<MovieData> homeListData = [];
  int pageNo = 2;

  HomeBloc({this.repository}) : super(HomeInitialState()) {
    on<HomeBlocEvent>(mapEventToState);
  }

  void mapEventToState(HomeBlocEvent event, Emitter<HomeBlocState> emit) async {
    try {
      HomeResponse? model;
      if( event is HomeFetchDataEvent) {
        emit(HomeLoadMoreState(true));
        model = await repository?.getHomeData(pageNo);
      } else {
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
    } catch (error, _) {
      emit(HomeError(error.toString()));
    }
  }
}
