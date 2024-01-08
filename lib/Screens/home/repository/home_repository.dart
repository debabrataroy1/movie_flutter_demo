import 'package:movie_flutter_demo/Constants/app_constants.dart';
import '../../../Models/home_model.dart';
import '../../../NetworkManager/api_services.dart';

abstract class HomeRepository {
  Future<HomeResponse?> getHomeData(int pageNo);
}

class HomeRepositoryImp implements HomeRepository {
  @override
  Future<HomeResponse?> getHomeData(int pageNo) async {
    HomeResponse? model = await APIServices().getHomeData(AppData.apiKey, pageNo);
    return model;
  }
}
