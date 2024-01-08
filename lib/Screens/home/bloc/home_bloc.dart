
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import '../repository/home_repository.dart';
import 'state/home_bloc_state.dart';
import 'event/home_bloc_event.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeRepository? repository;
  HomeResponse? carouselData;
  List<MovieData> homeListData = [];

  HomeBloc({this.repository}) : super(HomeInitialState()) {
    on<HomeBlocEvent>(mapEventToState);
  }

  void mapEventToState(HomeBlocEvent event, Emitter<HomeBlocState> emit) async {
    try {
      var model = await repository?.getHomeData(event.pageNo);
      if (model != null) {
        if( event is FetchCarouselDataEvent) {
          carouselData = model;
          emit(HomeCarouselSuccessState());
        } else {
          model.results?.forEach((element) {
            homeListData.add(element);
          });
          emit(HomeListSuccessState((model.page ?? 2) + 1));
        }
      } else {
        emit(HomeError(''));
      }
    } catch (error, _) {
      emit(HomeError(error.toString()));
    }
  }
}
