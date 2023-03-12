// ignore_for_file: constant_identifier_names



import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/app/constants.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "Content-Type";
const String AUTHORIZATION = "Authorization";
const String DEFAULT_LANGUAGE = "lang";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

   Future<Dio> getDio() async {
    Dio dio = Dio();

    String lang = await _appPreferences.getAppLanguage();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      AUTHORIZATION: Constants.token.orEmpty(),
      DEFAULT_LANGUAGE: lang,
    };

    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: headers,
        receiveTimeout: Constants.apiTimeOut,
        sendTimeout: Constants.apiTimeOut,
    );


    if(!kReleaseMode)
    {
      // its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}