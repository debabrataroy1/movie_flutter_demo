import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/app_constants.dart';
import 'package:movie_flutter_demo/Constants/app_string_constant.dart';
import 'package:movie_flutter_demo/Screens/account/account_page.dart';
import 'package:movie_flutter_demo/Screens/favourites/favourites_page.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/home_bloc.dart';
import 'package:movie_flutter_demo/Screens/home/home_page.dart';
import 'package:movie_flutter_demo/Screens/home/repository/home_repository.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  int _selectedIndex = 0;

    final List<Widget> _widgetOptions = [
    BlocProvider(
        create: ( context)=>HomeBloc(repository: HomeRepositoryImp()),
        child: const HomePage()),
    FavouritesPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _bottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(AppIcons.home),
          label: AppStrings.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.favourites),
          label: AppStrings.favourites,
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.account),
          label: AppStrings.account,
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _bottomBar(),
    );
  }
}