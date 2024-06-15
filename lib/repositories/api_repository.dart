import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todo_app/constant/app_config.dart';

part 'api_repository.g.dart';

@RestApi(baseUrl: AppConfig.baseApiUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("auth/login")
  Future<String> login(@Body() Map<String, dynamic> request);
}
