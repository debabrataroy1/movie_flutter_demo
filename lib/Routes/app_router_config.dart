import 'package:go_router/go_router.dart';
import 'package:movie_flutter_demo/Routes/app_router_constants.dart';

import '../Screens/home/home_page.dart';

class AppRouter {
  GoRouter router = GoRouter(
      routes: [
        GoRoute(name: AppRouteName.home,
            path: '/',
        builder: (context, state) => HomePage())
      ]
  );
}