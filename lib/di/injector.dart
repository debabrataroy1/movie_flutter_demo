import 'package:get_it/get_it.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref.dart';
import 'package:movie_flutter_demo/NetworkManager/api_services.dart';

class AppInjector {
  static final getIt = GetIt.instance;

  void setup() {
    _register(AppSharedPref());
    _register(APIServices());
  }

  void _register<T extends Object>(T instance) {
    if (!getIt.isRegistered(instance: instance)) {
      getIt.registerSingleton(instance);
    }
  }
}