import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Helper/bottom_loader.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/carousel_view.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/home_movie_list.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/home_cubit.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/state/home_bloc_state.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  late HomeCubit homeBloc;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);
  HomePage( {super.key}) {
    _scrollController.addListener(_scrollListener);
  }

  _loadMoreData() {
    homeBloc.getHomeData();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0 &&
        (homeBloc.pageNo < (homeBloc.totalPages))
        && !isLoading.value) {
      isLoading.value = true;
      _loadMoreData();
    }
  }

  @override
  Widget build(BuildContext context) {
    homeBloc = context.read<HomeCubit>();
    return Scaffold(
        appBar: AppBar(title: Text(AppLocalization.instance.keys.home)),
        body:SingleChildScrollView(
            controller: _scrollController,
            child:Column(
                children: [
                  BlocListener<HomeCubit, HomeBlocState>(
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
                      child: const SizedBox.shrink()
                  ),
                  BlocBuilder<HomeCubit, HomeBlocState>(
                      buildWhen: (context, state) {
                        return state is HomeCarouselSuccessState;
                      },
                      builder: (context, state) {
                        return (state is HomeCarouselSuccessState && state.carouselData.isNotEmpty) ?
                        CarouselView(state.carouselData)
                            : const SizedBox.shrink();
                      }
                  ),
                  BlocBuilder<HomeCubit, HomeBlocState>(
                      buildWhen: (context, state) {

                        return state is HomeListSuccessState;
                      },
                      builder: (context, state) {
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          isLoading.value = false;
                        });
                        return (state is HomeListSuccessState && state.listData.isNotEmpty) ?
                        HomeMovieList(AppLocalization.instance.keys.recentMovies, state.listData)
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
}