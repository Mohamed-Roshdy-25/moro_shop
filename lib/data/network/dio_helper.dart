import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );

    if (!kReleaseMode) {
      dio?.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': AppPreferences.getAppLanguage(),
      'Authorization': AppPreferences.getToken(),
    };

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  Future<Response> postData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': AppPreferences.getAppLanguage(),
      'Authorization': AppPreferences.getToken(),
    };

    return dio!.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  Future<Response> putData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': AppPreferences.getAppLanguage(),
      'Authorization': AppPreferences.getToken(),
    };

    return dio!.put(
      url,
      data: data,
      queryParameters: query,
    );
  }

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': AppPreferences.getAppLanguage(),
      'Authorization': AppPreferences.getToken(),
    };

    return dio!.delete(
      url,
      queryParameters: query,
    );
  }
}
