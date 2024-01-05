import 'package:go_router/go_router.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref.dart';
import 'package:movie_flutter_demo/Routes/app_router_constants.dart';
import 'package:movie_flutter_demo/Screens/login/login_page.dart';
import 'package:flutter/material.dart';
import '../Screens/home/home_page.dart';
import '../Screens/onboarding/onboarding_page.dart';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: '/',
      routes: [
        GoRoute(name: AppRouteName.home,
            path: '/home',
        builder: (context, state) => const HomePage()),
        GoRoute(name: AppRouteName.onboarding,
            path: '/',
            builder: (context, state) => const OnboardingPage()),
        GoRoute(name: AppRouteName.login,
            path: '/login',
            builder: (context, state) => const Login())
      ],
      redirect: (BuildContext context, GoRouterState state) async {
       if (state.fullPath == '/') {
         var isLogin = await AppSharedPref.isLogin();
         if (isLogin) {
          return '\\${AppRouteName.home}';
         } else {
          return null;
         }
       }
    }
  );
}