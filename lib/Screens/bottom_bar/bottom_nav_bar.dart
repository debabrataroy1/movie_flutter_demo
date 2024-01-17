import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/icons_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Screens/account/account_page.dart';
import 'package:movie_flutter_demo/Screens/favourites/favourites_page.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/home_bloc.dart';
import 'package:movie_flutter_demo/Screens/home/home_page.dart';
import 'package:movie_flutter_demo/Screens/home/repository/home_repository.dart';
import 'package:movie_flutter_demo/Screens/favourites/cubit/favourite_cubit.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    BlocProvider(
        create: ( context)=> HomeBloc(repository: HomeRepository()),
        child:  HomePage()),
    BlocProvider(
        create: ( context)=>FavouriteCubit(),
        child:  FavouritesPage()),
    const AccountPage(),
  ];
  @override
  void initState() {

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            items:[
              BottomNavigationBarItem(
                  icon:const Icon(AppIcons.home),
                  label: context.l10n.home
              ),
              BottomNavigationBarItem(
                  icon:const Icon(AppIcons.favourites),
                  label: context.l10n.favourites
              ),
              BottomNavigationBarItem(
                  icon:const Icon(AppIcons.account),
                  label: context.l10n.account
              )],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped
        )
    );
  }
}