import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_size_constants.dart';
import 'package:movie_flutter_demo/Constants/border_radius_constants.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Helper/image_view.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Routes/app_router_config.dart';

class CarouselView extends StatefulWidget {
  final List<MovieData> movieList;
  final List<int>? wishListItems;
  final Function(int,bool)? wishListAction;
  const CarouselView(this.movieList, {super.key, this.wishListAction, this.wishListItems});

  @override
  State<CarouselView> createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  int _currentPage = 0;
  int _totalPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _totalPage = widget.movieList.length;
    _pageController = PageController(initialPage: 0);
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();
        if (_currentPage < (_totalPage - 1)) {
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
        margin: const EdgeInsets.symmetric(horizontal: AppPaddings.mini),
        height: AppIconSize.extraSmall,
        width: AppIconSize.extraSmall,
        decoration: BoxDecoration(
            boxShadow: [
              isActive ? BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.72),
                  blurRadius: AppBorderRadius.small,
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
                height: ContanierSize.regular,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withAlpha(200),
                          Colors.black.withAlpha(0)]
                    )),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.movieList.map((element) {
                      return _indicator(element == widget.movieList[_currentPage]);
                    }).toList())
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return SizedBox(
        height: AppSize.width / 2,
        child: Stack(
            children: [
              PageView.builder(
                  itemCount: _totalPage,
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: (value) {
                    _currentPage = value;
                    setState(() { });
                    _animationController.forward();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        bool isWishlist = widget.wishListItems?.contains(widget.movieList[index].id) ?? false;
                        DetailRoute((widget.movieList[index], isWishlist,(id, value){
                          if (value != isWishlist) {
                            if (value) {
                              widget.wishListItems?.add(id);
                            }else {
                              widget.wishListItems?.remove(id);
                            }
                            if (widget.wishListAction != null) {
                              widget.wishListAction!(id, value);
                            }
                          }
                        })).push(context);
                      },
                      child:Hero(
                          tag: widget.movieList[index].id.toString(),
                          child: ImageView(url: ServerConstants.imageBaseUrl + (widget.movieList[index].imageUrl ?? '')
                          )
                      )
                    );
                  }),
              _buildPageIndicator()
            ])
    );
  }
}