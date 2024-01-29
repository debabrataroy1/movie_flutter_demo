import 'package:movie_flutter_demo/Constants/app_data.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'package:movie_flutter_demo/Models/home_model.dart';
import 'package:movie_flutter_demo/NetworkManager/api_services.dart';

class HomeRepository {
  late APIServices _apiServices;

  HomeRepository({APIServices? apiServices}) {
    _apiServices = apiServices ?? AppInjector.getIt<APIServices>();
  }

  @override
  Future<HomeResponse?> getHomeData(int pageNo) async {
    HomeResponse? model = await _apiServices.getHomeData(AppData.apiKey, pageNo);
    return model;
  }
}
