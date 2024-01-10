import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
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
  int pageNo = 2;
  @override
  void initState() {
    _homeBloc = context.read<HomeBloc>();
    _homeBloc.add(FetchCarouselDataEvent(1));
    _loadMoreData();

    super.initState();
  }

  _loadMoreData() {
    _homeBloc.add(HomeFetchDataEvent(pageNo));
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        notification.metrics.extentAfter == 0 &&
        (pageNo < (_homeBloc.carouselData?.totalPages ?? 0))) {
      _loadMoreData();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.home)),
        body:NotificationListener<ScrollNotification>(
            onNotification: _onNotification ,
            child: BlocProvider<HomeBloc>(
                create: (context)=> _homeBloc,
                child: SingleChildScrollView(
                    child: BlocConsumer<HomeBloc, HomeBlocState>(
                        listener: (context, state) {
                          if (state is HomeError) {
                            SnackBar snackBar = SnackBar(
                                content: Text(state.message ?? '')
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else if (state is HomeListSuccessState) {
                            pageNo = state.nextPage ?? 2;
                          }
                        },
                        builder: (context, state) {
                          return Column(children: [
                            Visibility(
                                visible: (_homeBloc.carouselData?.results?.length ?? 0) > 0,
                                child: CarouselView(_homeBloc.carouselData?.results)),
                            Visibility(
                                visible: _homeBloc.homeListData.isNotEmpty,
                                child: HomeMovieList(_homeBloc.homeListData, isLoading: pageNo < 3 ? false
                                    : pageNo < (_homeBloc.carouselData?.totalPages ?? 0)
                                )
                            )
                          ]);
                        })
                )
            )
        )
    );
  }
}
