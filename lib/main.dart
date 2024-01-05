import 'package:flutter/material.dart';

import 'Routes/app_router_config.dart';
import 'Theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var _router = AppRouter().router;
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeManager.instance.light,
      darkTheme: ThemeManager.instance.dark,
      routerConfig: _router,
    );
  }
}
