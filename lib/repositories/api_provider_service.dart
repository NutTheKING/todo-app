import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:todo_app/constant/app_config.dart';
import 'package:todo_app/domain/enums/local_services.dart';
import 'package:todo_app/service/global_service.dart';
import 'package:todo_app/service/local_service.dart';

import 'api_repository.dart';

class ApiProviderService {
  ApiProviderService._internal();

  static final ApiProviderService _instance = ApiProviderService._internal();
  HttpClient globalHttpClient = HttpClient();

  factory ApiProviderService() {
    return _instance;
  }

  String _baseUrl = "";
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 6000),
      sendTimeout: const Duration(milliseconds: 6000),
      receiveTimeout: const Duration(milliseconds: 6000),
      baseUrl: AppConfig.baseApiUrl,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
      },
    ),
  );

  RestClient getRestClientLogin() {
    final Dio _dio = Dio();
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };
    return RestClient(_dio, baseUrl: AppConfig.baseApiUrl);
  }

  RestClient getRestClient() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      return httpClient;
    };
    return RestClient(_dio, baseUrl: _baseUrl);
  }

  RestClient putRestClientTest(String taskEc, String priority) {
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      return httpClient;
    };
    return RestClient(_dio, baseUrl: "${AppConfig.baseApiUrl}/api/v3/taskassignment/priority/$taskEc/$priority");
  }

  RestClient getPutClient() {
    _dio.options.headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "User-Agent": "https://www.thunderclient.com",
      "Authorization": "Bearer ${GlobalService().accessToken}",
    };
    return RestClient(_dio, baseUrl: _baseUrl);
  }

  RestClient putTaskClient() {
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "User-Agent": "https://www.thunderclient.com",
      "Authorization": "Bearer ${GlobalService().accessToken}",
    };
    return RestClient(_dio, baseUrl: _baseUrl);
  }

  RestClient putClientFile() {
    _dio.options.headers = {
      "Content-Type": "multipart/form-data",
      'Accept': 'application/json',
      "Authorization": "Bearer ${GlobalService().accessToken}",
    };
    _dio.options.contentType = "pdf";
    return RestClient(_dio, baseUrl: "${AppConfig.baseApiUrl}/FileUploader/task-subtask");
  }

  RestClient putClientImage(String taskec) {
    _dio.options.headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      "Authorization": "Bearer ${GlobalService().accessToken}",
    };
    return RestClient(_dio,
        baseUrl: "${AppConfig.baseApiUrl}/FileUploader/attachment?taskec=$taskec&&AttachmentType=Original");
  }

  RestClient deleteClientImage() {
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${GlobalService().accessToken}",
    };
    return RestClient(_dio, baseUrl: AppConfig.baseApiUrl);
  }

  RestClient deleteClient() {
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${GlobalService().accessToken}",
    };
    return RestClient(_dio, baseUrl: _baseUrl);
  }

  RestClient postClient() {
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${GlobalService().accessToken}",
    };
    return RestClient(_dio, baseUrl: _baseUrl);
  }

  getInstance({String baseUrl = AppConfig.baseApiUrl, bool shouldAddInterceptor = false}) {
    _baseUrl = baseUrl;

    if (shouldAddInterceptor) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }
  }

  setUserAccessToken(String accessToken) {
    LocalService().saveValue(LocalDataFieldName.USER_TOKEN, accessToken);
    _dio.options.headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken",
    };
    GlobalService().accessToken = accessToken;
  }

  clearUserAccessToken() {
    LocalService().deleteSavedValue(LocalDataFieldName.USER_TOKEN);
    _dio.options.headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    };
    GlobalService().accessToken = "";
  }
}
