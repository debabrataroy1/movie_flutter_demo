import 'package:movie_flutter_demo/Constants/app_data.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import '../../../Models/home_model.dart';
import '../../../NetworkManager/api_services.dart';

abstract class HomeRepository {
  Future<HomeResponse?> getHomeData(int pageNo);
}

class HomeRepositoryImp implements HomeRepository {
  late APIServices _apiServices;

  HomeRepositoryImp() {
    _apiServices = AppInjector.getIt<APIServices>();
  }

  @override
  Future<HomeResponse?> getHomeData(int pageNo) async {
    HomeResponse? model = await _apiServices.getHomeData(AppData.apiKey, pageNo);
    return model;
  }
}
