import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Helper/bottom_loader.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/event/home_bloc_event.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/carousel_view.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/home_movie_list.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/home_bloc.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/state/home_bloc_state.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';

class HomePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  List<int> _wishListItems = [];
  late HomeBloc homeBloc;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);
  HomePage( {super.key}) {
    _scrollController.addListener(_scrollListener);
  }

  _loadMoreData() {
    homeBloc.mapEventToState(HomeFetchDataEvent());
  }

  bool _scrollListener() {
    if (_scrollController.position.extentAfter == 0 &&
        (homeBloc.pageNo < (homeBloc.totalPages ?? 0))
        && !isLoading.value) {
      isLoading.value = true;
      _loadMoreData();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    homeBloc = context.read<HomeBloc>();
    return Scaffold(
        appBar: AppBar(title: Text(AppLocalization.instance.keys.home)),
        body:SingleChildScrollView(
            controller: _scrollController,
            child:Column(
                children: [
                  BlocListener<HomeBloc, HomeBlocState>(
                    listenWhen: (context, state) {
                      return state is HomeError || state is AllWishListState;
                    },
                    listener: (context, state) {
                      if (state is HomeError) {
                        SnackBar snackBar = SnackBar(
                            content: Text(state.message ?? '')
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } if (state is AllWishListState) {
                        _wishListItems = state.wishListItems;
                      }
                    },
                    child: const SizedBox.shrink()
                  ),
                  BlocBuilder<HomeBloc, HomeBlocState>(
                      buildWhen: (context, state) {
                        return state is HomeCarouselSuccessState;
                      },
                      builder: (context, state) {
                        return  homeBloc.homeCarouselData.isNotEmpty ?
                        CarouselView(homeBloc.homeCarouselData, wishListAction:_wishListAction, wishListItems: _wishListItems)
                        : const SizedBox.shrink();
                      }
                  ),
                  BlocBuilder<HomeBloc, HomeBlocState>(
                      buildWhen: (context, state) {
                        return state is HomeListSuccessState;
                      },
                      builder: (context, state) {
                        isLoading.value = false;
                        return  homeBloc.homeListData.isNotEmpty ?
                        HomeMovieList(AppLocalization.instance.keys.recentMovies, homeBloc.homeListData, wishListAction:_wishListAction, wishListItems: _wishListItems)
                        : const SizedBox.shrink();
                      }
                  ),
                  ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, value, _) {
                      return isLoading.value ? const BottomLoader() : const SizedBox.shrink();
                    }
                  )
                ])
        )
    );
  }
  _wishListAction(int id, bool value) {
    if (value) {
      _wishListItems.add(id);
    } else {
      _wishListItems.remove(id);
    }
  }
}