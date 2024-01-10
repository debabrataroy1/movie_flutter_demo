import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref.dart';
import 'package:movie_flutter_demo/Routes/app_router_constants.dart';
import 'package:movie_flutter_demo/Screens/account/account_page.dart';
import 'package:movie_flutter_demo/Screens/bottom_bar/bottom_nav_bar.dart';
import 'package:movie_flutter_demo/Screens/favourites/favourites_page.dart';
import 'package:movie_flutter_demo/Screens/home/bloc/home_bloc.dart';
import 'package:movie_flutter_demo/Screens/home/repository/home_repository.dart';
import 'package:movie_flutter_demo/Screens/login/login_page.dart';
import 'package:flutter/material.dart';
import '../Screens/home/home_page.dart';
import '../Screens/onboarding/onboarding_page.dart';
part 'app_router_config.g.dart';

class AppRouter {
  GoRouter router = GoRouter(
      initialLocation: '/',
      routes: $appRoutes,
      redirect: (BuildContext context, GoRouterState state) async {
        var app = GetIt.instance<AppSharedPref>();
        if (state.fullPath == '/') {
          var isLogin = await app.getBool(key: AppSharedPrefKey.loginStatus);
          if (isLogin) {
            return const BottombarRoute().location;
          } else {
            return null;
          }
        }
      }
  );
}

@TypedGoRoute<LoginRoute>(
  path: '/${AppRouteName.login}',
)
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Login();
}


@TypedGoRoute<OnboardingRoute>(
  path: '/',
)
class OnboardingRoute extends GoRouteData {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingPage();
}

@TypedGoRoute<HomeRoute>(
  path: '/${AppRouteName.home}',
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider(
          create: ( context)=>HomeBloc(repository: HomeRepositoryImp()),
          child: const HomePage());
}

@TypedGoRoute<BottombarRoute>(
  path: '/${AppRouteName.bottomBar}',
)
class BottombarRoute extends GoRouteData {
  const BottombarRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AppBottomBar();
}

@TypedGoRoute<AccountRoute>(
  path: '/${AppRouteName.account}',
)
class AccountRoute extends GoRouteData {
  const AccountRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AccountPage();
}

@TypedGoRoute<FavouritesRoute>(
  path: '/${AppRouteName.favourites}',
)
class FavouritesRoute extends GoRouteData {
  const FavouritesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FavouritesPage();
}
