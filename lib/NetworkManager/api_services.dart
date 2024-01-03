import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../Constants/api_constants.dart';
import 'api_errors.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ServerConstants.baseUrl)
abstract class APIServices {
  factory APIServices({String? baseUrl}) {
    Dio dio = Dio();
    dio.options = BaseOptions(baseUrl: ServerConstants.baseUrl);
    dio.interceptors
        .add(InterceptorsWrapper(onError: (DioException e, handler) {
      DioCustomError err =
          DioCustomError(DioExceptions.fromDioError(e).message ?? '', e);
      return handler.next(err);
    }));
    return _APIServices(dio, baseUrl: baseUrl);
  }
}
