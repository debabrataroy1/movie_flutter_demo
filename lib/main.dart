import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/app_data.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'Routes/app_router_config.dart';
import 'Theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppInjector().setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    var router = AppRouter().router;
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode ==
              locale?.languageCode &&
              supportedLocaleLanguage.countryCode ==
                  locale?.countryCode) {
            return supportedLocaleLanguage;
          }
        }
        return supportedLocales.first;
      },
      locale: AppData.locale,
      title: 'Flutter Demo',
      theme: ThemeManager.instance.light,
      darkTheme: ThemeManager.instance.dark,
      routerConfig: router
    );
  }
}