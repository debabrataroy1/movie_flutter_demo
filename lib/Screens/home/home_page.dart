import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Helper/bottom_loader.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/event/home_bloc_event.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/carousel_view.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/home_movie_list.dart';

import 'bloc/home_bloc.dart';
import 'bloc/state/home_bloc_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;
  @override
  void initState() {
    _homeBloc = context.read<HomeBloc>();
    _homeBloc.add(FetchCarouselDataEvent());
    _loadMoreData();

    super.initState();
  }

  _loadMoreData() {
    _homeBloc.add(HomeFetchDataEvent());
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        notification.metrics.extentAfter == 0 &&
        (_homeBloc.pageNo < (_homeBloc.carouselData?.totalPages ?? 0))) {
      _loadMoreData();
    }
    return false;
  }

  Widget _blocListener() {
    return BlocListener<HomeBloc, HomeBlocState>(
        listenWhen: (context, state) {
          return state is HomeError;
        },
        listener: (context, state) {
          if (state is HomeError) {
            SnackBar snackBar = SnackBar(
                content: Text(state.message ?? '')
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Container()
    );
  }

  Widget _carouselWidget() {
    return BlocBuilder<HomeBloc, HomeBlocState>(
        buildWhen: (context, state) {
          return state is HomeCarouselSuccessState;
        },
        bloc: _homeBloc,
        builder: (context, state) {
          if (state is HomeCarouselSuccessState) {
            return  Visibility(
                visible: (_homeBloc.carouselData?.results?.length ?? 0) > 0,
                child: CarouselView(_homeBloc.carouselData?.results));
          }
          return const SizedBox.shrink();
        }
    );
  }
  Widget _listWidget() {
    return BlocBuilder<HomeBloc, HomeBlocState>(
        buildWhen: (context, state) {
          return state is HomeListSuccessState;
        },
        bloc: _homeBloc,
        builder: (context, state) {
          if (state is HomeListSuccessState) {
            return  Visibility(
                visible: _homeBloc.homeListData.isNotEmpty,
                child: HomeMovieList(_homeBloc.homeListData));
          }
          return const SizedBox.shrink();
        }
    );
  }

  Widget _bottomWidget() {
    return BlocBuilder<HomeBloc, HomeBlocState>(
      buildWhen: (context, state) {
        return state is HomeLoadMoreState;
      },
      bloc: _homeBloc,
      builder: (context, state) {
        if (state is HomeLoadMoreState) {
          return  Visibility(
              visible: state.isLoadMore ?? false,
              child: const BottomLoader());
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.home)),
        body:NotificationListener<ScrollNotification>(
            onNotification: _onNotification,
            child: BlocProvider<HomeBloc>(
                create: (context)=> _homeBloc,
                child: SingleChildScrollView(
                    child:Column(
                        children: [
                          _blocListener(),
                          _carouselWidget(),
                          _listWidget(),
                          _bottomWidget()
                        ])
                )
            )
        )
    );
  }
}
