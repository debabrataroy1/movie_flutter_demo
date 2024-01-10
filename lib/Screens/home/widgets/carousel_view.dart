import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Helper/ImageView.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';

class CarouselView extends StatefulWidget {
  List<MovieData>? movieList;
  CarouselView(this.movieList, {super.key});

  @override
  State<CarouselView> createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  int _currentPage = 0;
  int totalPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    totalPage = widget.movieList?.length ?? 0;
    _pageController = PageController(initialPage: 0);
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();
        if (_currentPage < (totalPage - 1)) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(_currentPage,
            duration: const Duration(milliseconds: 300), curve: Curves.easeInSine);
        setState(() { });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _indicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: AppIconSize.extraSmall,
      width: AppIconSize.extraSmall,
      decoration: BoxDecoration(
        boxShadow: [
          isActive ? BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.72),
            blurRadius: 4.0,
            spreadRadius: 1.0
          ) : const BoxShadow(
            color: Colors.transparent
          )
        ],
        shape: BoxShape.circle,
        color: isActive ? AppColors.primaryColor : const Color(0XFFEAEAEA)
      )
    );
  }

  Widget _buildPageIndicator() {
    return Positioned.fill(
        bottom: 0,
        child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withAlpha(200),
                      Colors.black.withAlpha(0)]
                )),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.movieList?.map((element) {
                  return _indicator(element == widget.movieList?[_currentPage]);
                }).toList() ?? [])
          )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return SizedBox(
        height: MediaQuery.of(context).size.width / 2,
        child: Stack(
        children: [
          PageView.builder(
            itemCount: totalPage,
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            onPageChanged: (value) {
              _currentPage = value;
              setState(() { });
              _animationController.forward();
            },
            itemBuilder: (BuildContext context, int index) {
              return ImageView(url: ServerConstants.imageBaseUrl + (widget.movieList?[index].imageUrl ?? '')
              );
            }),
          _buildPageIndicator()
        ])
    );
  }
}