import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/app_data.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref_key.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';
import 'package:movie_flutter_demo/Utils/app_shared_pref.dart';
import 'package:movie_flutter_demo/Constants/icons_constants.dart';
import 'package:movie_flutter_demo/Routes/app_router_config.dart';
import 'package:movie_flutter_demo/Screens/account/account_page.dart';
import 'package:movie_flutter_demo/Screens/favourites/favourites_page.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/home_bloc.dart';
import 'package:movie_flutter_demo/Screens/home/home_page.dart';
import 'package:movie_flutter_demo/Screens/home/repository/home_repository.dart';
import 'package:movie_flutter_demo/Screens/favourites/cubit/favourite_cubit.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'package:intl/intl.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> with WidgetsBindingObserver{
  int _selectedIndex = 0;
  final DateFormat _dateFormat = DateFormat(AppData.dateFormat);
  final SharedPref sharedInstance = AppInjector.getIt<SharedPref>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      sharedInstance.setString(key: AppSharedPrefKey.lastActive, value: _dateFormat.format(DateTime.now()));
    } else if (state == AppLifecycleState.resumed) {
      _checkSession();
    }
  }
  _checkSession() {
    String lastActiveTime = sharedInstance.getString(key: AppSharedPrefKey.lastActive);
    if (lastActiveTime.isNotEmpty) {
      DateTime dateTime = _dateFormat.parse(lastActiveTime);
      if (DateTime
          .now()
          .difference(dateTime)
          .inMinutes > 15) {
        sharedInstance.remove(AppSharedPrefKey.loginStatus);
        sharedInstance.remove(AppSharedPrefKey.lastActive);
        const OnboardingRoute().go(context);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  late List<Widget> _widgetOptions;
  @override
  void initState() {
    _checkSession();
    WidgetsBinding.instance.addObserver(this);
    _widgetOptions = [
      BlocProvider(
          create: ( context)=> HomeBloc(repository: HomeRepository()),
          child:  HomePage()),
      BlocProvider(
          create: ( context)=>FavouriteCubit(),
          child:  FavouritesPage()),
      AccountPage(),
    ];
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
                  label: AppLocalization.instance.keys.home
              ),
              BottomNavigationBarItem(
                  icon:const Icon(AppIcons.favourites),
                  label: AppLocalization.instance.keys.favourites
              ),
              BottomNavigationBarItem(
                  icon:const Icon(AppIcons.account),
                  label: AppLocalization.instance.keys.account
              )],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped
        )
    );
  }
}