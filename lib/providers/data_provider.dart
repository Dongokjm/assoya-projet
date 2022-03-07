import 'package:assoya/models/ride.dart';
import 'package:assoya/models/vehicule.dart';
import 'package:assoya/utilities/constants.dart' as Constants;
import 'package:assoya/utilities/dio_interceptor.dart';
import 'package:assoya/utilities/logger.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum WorkStatus { None, Working, Error }

class DataProvider extends ChangeNotifier {
  final DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
  WorkStatus? status = WorkStatus.None;
  List<Ride> rides = [];
  List<Vehicule> cars = [];
  Dio getSingleDio() {
    final Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    _dio.interceptors.add(CustomInterceptors());
    return _dio;
  }

  fetchRides() async {
    status = WorkStatus.Working;
    notifyListeners();
    try {
      var dioResponse = await getSingleDio().get(Constants.RIDE_URL);
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> jsonResponse = dioResponse.data;
        if (jsonResponse.containsKey("trajets")) {
          var data = jsonResponse['trajets'];
          logSuccess(data.toString());
          for (var n in data) {
            Ride r = Ride.fromJson(n);
            rides.add(r);
          }
        }
      }
      status = WorkStatus.None;
      notifyListeners();
    } on DioError catch (e) {
      status = WorkStatus.Error;
      notifyListeners();
      logError(e.message);
    }
  }

  fetchCars() async {
    cars.clear();
    status = WorkStatus.Working;
    notifyListeners();
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");

      Options _cacheOptions = buildCacheOptions(const Duration(seconds: 1),
          forceRefresh: true,
          options: Options(
            headers: {
              // set content-length
              'Authorization': "Bearer ${token}", // set content-length
            },
          ));
      var dioResponse = await getSingleDio()
          .get(Constants.USER_VEHICULE_URL, options: _cacheOptions);
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> jsonResponse = dioResponse.data;
        if (jsonResponse.containsKey("data")) {
          if (jsonResponse["data"].containsKey("vehicules")) {
            var data = jsonResponse["data"]['vehicules'];
            logSuccess(data.toString());
            for (var n in data) {
              Vehicule r = Vehicule.fromJson(n);
              cars.add(r);
            }
          }
        }
      }
      status = WorkStatus.None;
      notifyListeners();
    } on DioError catch (e) {
      status = WorkStatus.Error;
      notifyListeners();
      logError(e.message);
    }
  }

  storeVehicule(Map<String, dynamic> vehiculeData) async {
    status = WorkStatus.Working;
    notifyListeners();
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");

      Options _cacheOptions = buildCacheOptions(const Duration(seconds: 1),
          forceRefresh: true,
          options: Options(
            headers: {
              // set content-length
              'Authorization': "Bearer ${token}", // set content-length
            },
          ));

      final finalData = Map.of(vehiculeData);

      finalData["photo"] = await MultipartFile.fromFile(
          finalData["photo"][0].path,
          filename: finalData["photo"][0].name);
      // logInfo(finalData["photo"][0].toString());
      var formData = FormData.fromMap(finalData);
      var dioResponse = await getSingleDio().post(Constants.ADD_VEHICULE_URL,
          options: _cacheOptions, data: formData);
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> jsonResponse = dioResponse.data;
        logSuccess(
            "[Store Vehicule Success] ${jsonResponse["data"]["vehicules"]}");
      }
      status = WorkStatus.None;
      notifyListeners();
    } on DioError catch (e) {
      status = WorkStatus.Error;
      notifyListeners();
      logError("[Store Vehicule Error] ${e.message}");
    }
  }

  updateVehicule(Map<String, dynamic> vehiculeData, int id) async {
    status = WorkStatus.Working;
    notifyListeners();
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");

      Options _cacheOptions = buildCacheOptions(const Duration(seconds: 1),
          forceRefresh: true,
          options: Options(
            headers: {
              // set content-length
              'Authorization': "Bearer ${token}", // set content-length
            },
          ));
      var url = Constants.UPDATE_VEHICULE_URL.replaceAll("{id}", id.toString());
      var formData = FormData.fromMap(vehiculeData);
      var dioResponse = await getSingleDio()
          .post(url, options: _cacheOptions, data: formData);
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> jsonResponse = dioResponse.data;
        status = WorkStatus.None;
        notifyListeners();
        logSuccess(
            "[Update Vehicule Success] ${jsonResponse["data"]["vehicules"]}");
      }
    } on DioError catch (e) {
      status = WorkStatus.Error;
      notifyListeners();
      logError("[Update Vehicule Error] ${e.message}");
    }
  }

  Future<bool> deleteVehicule(int id) async {
    status = WorkStatus.Working;
    notifyListeners();
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");

      Options _cacheOptions = buildCacheOptions(const Duration(seconds: 1),
          forceRefresh: true,
          options: Options(
            headers: {
              // set content-length
              'Authorization': "Bearer ${token}", // set content-length
            },
          ));
      var url = Constants.DELETE_VEHICULE_URL.replaceAll("{id}", id.toString());

      var dioResponse = await getSingleDio().get(url, options: _cacheOptions);
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> jsonResponse = dioResponse.data;
        status = WorkStatus.None;
        notifyListeners();
        Fluttertoast.showToast(
            msg: "Véhicule supprimé avec succès",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        logSuccess("[Delete Vehicule Success] ${jsonResponse["message"]}");
      }
      return true;
    } on DioError catch (e) {
      status = WorkStatus.Error;
      notifyListeners();
      logError("[Delete Vehicule Error] ${e.message}");
      return false;
    }
  }
}
