import 'package:go_router/go_router.dart';
import 'package:movie_flutter_demo/Routes/app_router_constants.dart';

import '../Screens/home/home_page.dart';
import '../Screens/onboarding/onboarding_page.dart';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: '/',
      routes: [
        GoRoute(name: AppRouteName.home,
            path: '/home',
        builder: (context, state) => HomePage()),
        GoRoute(name: AppRouteName.onboarding,
            path: '/',
            builder: (context, state) => OnboardingPage())

      ]
  );
}