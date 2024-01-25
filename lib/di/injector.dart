import 'package:get_it/get_it.dart';
import 'package:movie_flutter_demo/Models/user_model.dart';
import 'package:movie_flutter_demo/Utils/app_shared_pref.dart';
import 'package:movie_flutter_demo/NetworkManager/api_services.dart';
import 'package:movie_flutter_demo/Utils/app_encryption.dart';
import 'package:movie_flutter_demo/Utils/encryption/encrypt_implemention.dart';
import 'package:movie_flutter_demo/Utils/file_manager.dart';
import 'package:movie_flutter_demo/Utils/sql_db/sql_db_manager.dart';
import 'package:movie_flutter_demo/Utils/db_manager.dart';

class AppInjector {
  static final getIt = GetIt.instance;

  void setup() {
    _register<SharedPref>(AppSharedPref());
    _register(APIServices());
    _register<DBManager>(SQLDBManager());
    _register<Encryption>(Encrypt());
    _register<FileManager>(PathFileManager());
    _register(User());
  }

  void _register<T extends Object>(T instance) {
    if (!getIt.isRegistered(instance: instance)) {
      getIt.registerSingleton<T>(instance);
    }
  }
}