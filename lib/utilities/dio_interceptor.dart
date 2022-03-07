import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:assoya/utilities/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
Dio getSingleDio() {
  final Dio _dio = Dio();
  _dio.interceptors.add(_dioCacheManager.interceptor);
  _dio.interceptors.add(CustomInterceptors());
  return _dio;
}

class CustomInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token != null) {
      options.headers["Authorization"] = "Bearer ${token}";
    }
    logInfo('DIO REQUEST [${options.method}] => PATH: ${options.path}');
    logInfo(options.headers.toString());
    logInfo(options.data.toString());
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 401) {
      Map<String, dynamic> jsonResponse = response.data;
      if (jsonResponse.containsKey("status")) {
        if (jsonResponse["status"] == 401) {
          logWarning("DIO TOKEN EXPIRED [REFRESHING...]");
          // await Provider.of<AuthProvider>(getx.Get.context!, listen: false)
          //     .updateToken()
          //     .then((value) async {
          //   await _retry(response.requestOptions);
          // });
        }
      }
    }

    logWarning("DIO STATUS CODE  [${response.statusCode}]");
    logWarning("DIO RESPONSE  [${response.data}]");
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    logError("DIO INTERCEPTOR ERROR [${err.message}]");
    logError("DIO INTERCEPTOR STACKTRACE [${err.stackTrace.toString()}]");
    if (err.response != null) {
      logError("DIO INTERCEPTOR ERROR CODE [${err.response!.statusCode}]");
      if (err.response!.statusCode == 401) {
        Map<String, dynamic> jsonResponse = err.response!.data;
        logWarning("DIO TOKEN EXPIRED [REFRESHING...]");
        if (jsonResponse.containsKey("status")) {
          if (jsonResponse["status"] == 401) {
            // await Provider.of<AuthProvider>(getx.Get.context!, listen: false)
            //     .updateToken()
            //     .then((value) async {
            //   return _retry(err.requestOptions);
            // });
          }
        }
      }
    }
    logError("DIO INTERCEPTOR ERROR DATA [${err.response!.data}]");
    logError(err.stackTrace.toString());

    return handler.next(err);
  }

  /// - [DioInterceptor Retry]
  ///   will relaunch the previous failed request due to 401 error
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    logInfo("DIO TOKEN UPDATED [RE-LAUNCHING...]");
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var headers = requestOptions.headers;
    headers["Authorization"] = token;
    final options = new Options(
      method: requestOptions.method,
      headers: headers,
    );

    logInfo("[RE-LAUNCHING HEADERS] : [${requestOptions.headers.toString()}]");
    return getSingleDio().request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
