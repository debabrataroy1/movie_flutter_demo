import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/app_size_constants.dart';
import 'package:movie_flutter_demo/Constants/border_radius_constants.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icons_constants.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/WishlistButton/wishList_button_cubit.dart';
import 'package:movie_flutter_demo/Screens/home/widgets/WishlistButton/wishlist_cubit_state.dart';

class WishListButtonWidget extends StatefulWidget {
  final MovieData movie;
  bool isWishlist;
  final Function(int, bool)? wishListAction;
  WishListButtonWidget({super.key, required this.movie, required this.isWishlist, this.wishListAction});

  @override
  State<WishListButtonWidget> createState() => _WishListButtonWidgetState();
}

class _WishListButtonWidgetState extends State<WishListButtonWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync:this, value: 1.0);


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<WishListCubit, WishListState>(
        listener: (context, state) {
          if (state is WishListError) {
            SnackBar snackBar = SnackBar(
                content: Text(state.message ?? '')
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is WishListSuccess) {
            widget.isWishlist = !widget.isWishlist;
            _controller
                .reverse()
                .then((value) => _controller.forward());
            if (widget.wishListAction != null) {
              widget.wishListAction!(widget.movie.id ?? 0, widget.isWishlist);
            }
          }
        },
        builder: (context, state) {
          return InkWell(
              onTap: () {
                final cubit = context.read<WishListCubit>();
                cubit.addRemoveWishlist(context, widget.movie, isNeedToAdd: !widget.isWishlist);
              },
              child: Container(
                  width: ContanierSize.regular,
                  height: ContanierSize.regular,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppBorderRadius.large))
                  ),
                  child: ScaleTransition(
                  scale: Tween(begin: 0.7, end: 1.0).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
              child: Center(
                      child: Icon(
                          AppIcons.favouriteFill,
                          size: AppIconSize.large,
                          color: (widget.isWishlist ? AppColors.primaryColor : Colors.grey))
                  )
              ))
          );
        }
    );
  }
}