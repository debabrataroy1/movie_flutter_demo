import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Helper/bottom_loader.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/event/home_bloc_event.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/carousel_view.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/home_movie_list.dart';
import 'bloc/home_bloc.dart';
import 'bloc/state/home_bloc_state.dart';

class HomePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  List<int> _wishListItems = [];
  late HomeBloc homeBloc;

  HomePage( {super.key}) {
    _scrollController.addListener(_scrollListener);
  }

  _loadMoreData() {
    homeBloc.mapEventToState(HomeFetchDataEvent());
  }

  bool _scrollListener() {
    if (_scrollController.position.extentAfter == 0 &&
        (homeBloc.pageNo < (homeBloc.carouselData?.totalPages ?? 0))
        && !homeBloc.isLoading) {
      _loadMoreData();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    homeBloc = context.read<HomeBloc>();
    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.home)),
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
                    child: const SizedBox.shrink(),
                  ),
                  BlocBuilder<HomeBloc, HomeBlocState>(
                      buildWhen: (context, state) {
                        return state is HomeCarouselSuccessState;
                      },
                      builder: (context, state) {
                        return  Visibility(
                            visible: (homeBloc.carouselData?.results?.length ?? 0) > 0,
                            child: CarouselView(homeBloc.carouselData?.results));
                      }
                  ),
                  BlocBuilder<HomeBloc, HomeBlocState>(
                      buildWhen: (context, state) {
                        return state is HomeListSuccessState;
                      },
                      builder: (context, state) {
                        return  Visibility(
                            visible: homeBloc.homeListData.isNotEmpty,
                            child: HomeMovieList(context.l10n.recentMovies, homeBloc.homeListData, wishListAction:(id, isAdded){
                              if (isAdded) {
                                _wishListItems.add(id);
                              } else {
                                _wishListItems.remove(id);
                              }
                            }, wishListItems: _wishListItems));
                      }
                  ),
                  BlocBuilder<HomeBloc, HomeBlocState>(
                      buildWhen: (context, state) {
                        return state is HomeLoadMoreState;
                      },
                      builder: (context, state) {
                        return  Visibility(
                            visible: (state as HomeLoadMoreState).isLoadMore ?? false,
                            child: const BottomLoader());
                      }
                  )
                ])
        )
    );
  }
}