import 'package:assoya/models/solde.dart';
import 'package:assoya/models/user.dart';
import 'package:assoya/models/user_profile.dart';
import 'package:assoya/utilities/dio_interceptor.dart';
import 'package:assoya/utilities/logger.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:dio/dio.dart' as dio;
import 'package:assoya/utilities/constants.dart' as Constants;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum WorkStatus { None, LoginIn, Registering, Working, Error }
enum LoggedStatus { None, LoggedIn, Logout }

class AuthProvider extends ChangeNotifier {
  final DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
  WorkStatus? status = WorkStatus.None;
  LoggedStatus? loggedStatus = LoggedStatus.None;
  var formErrors = [];
  Map<String, dynamic> formData = {};
  UserProfile? userProfile;
  Solde? solde;
  dio.Dio getSingleDio() {
    final dio.Dio _dio = dio.Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    _dio.interceptors.add(CustomInterceptors());
    return _dio;
  }

  Future<void> doLogin(User user) async {
    var prefs = await SharedPreferences.getInstance();
    status = WorkStatus.LoginIn;
    notifyListeners();
    try {
      var formData = dio.FormData.fromMap(
          {"login": user.login, "password": user.password});

      var dioResponse =
          await getSingleDio().post(Constants.LOGIN_URL, data: formData);
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> jsonResponse = dioResponse.data;
        if (jsonResponse.containsKey("access_token")) {
          var token = jsonResponse['access_token'];
          if (jsonResponse.containsKey("auth_user")) {
            var auth_user = jsonResponse['auth_user'];
            if (auth_user != null) {
              userProfile = UserProfile.fromJson(auth_user);
              await prefs
                  .setString("auth_user", convert.jsonEncode(auth_user))
                  .catchError((onError) {
                debugPrint("[set auth_user error] ${onError.toString()}");
              });
            }
          }
          await prefs.setString("token", token);
          debugPrint("[set auth_user started]}");
          status = WorkStatus.None;
          loggedStatus = LoggedStatus.LoggedIn;
          notifyListeners();
          Get.toNamed("/home");
        } else if (jsonResponse.containsKey("errors")) {
          var errors = jsonResponse['errors'];
          formErrors.addAll(errors);
          loggedStatus = LoggedStatus.None;
          status = WorkStatus.Error;
          notifyListeners();
          Get.snackbar("Erreur!!", "${jsonResponse['errors']}",
              colorText: Colors.white,
              backgroundColor: Color.fromARGB(255, 243, 204, 32),
              icon: Icon(Icons.warning));
        } else if (jsonResponse.containsKey("message") &&
            jsonResponse.containsKey("status")) {
          loggedStatus = LoggedStatus.None;
          status = WorkStatus.None;
          notifyListeners();
          var response_status = jsonResponse["status"];
          if (response_status == 401) {
            Get.toNamed("/verification");
          }
          Get.snackbar("Erreur!!", "${jsonResponse['message']}",
              colorText: Colors.white,
              backgroundColor: Color.fromARGB(255, 243, 204, 32),
              icon: Icon(Icons.warning));
        }
      }
    } catch (e) {
      status = WorkStatus.Error;
      loggedStatus = LoggedStatus.None;
      notifyListeners();
      Get.snackbar("Une Erreur serveur est survenue", "${e.toString()}",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 243, 204, 32));
    }
  }

  Future<void> doRegister() async {
    status = WorkStatus.LoginIn;
    notifyListeners();
    try {
      final finalData = Map.of(formData);
      logInfo(finalData.toString());

      if (finalData.containsKey("cni_recto")) {
        finalData["cni_recto"] = await dio.MultipartFile.fromFile(
            finalData["cni_recto"].path,
            filename: finalData["cni_recto"].name);
      }

      if (finalData.containsKey("cni_verso")) {
        finalData["cni_verso"] = await dio.MultipartFile.fromFile(
            finalData["cni_verso"].path,
            filename: finalData["cni_verso"].name);
      }

      if (finalData.containsKey("permis_recto")) {
        finalData["permis_recto"] = await dio.MultipartFile.fromFile(
            finalData["permis_recto"].path,
            filename: finalData["permis_recto"].name);
      }
      if (finalData.containsKey("permis_verso")) {
        finalData["permis_verso"] = await dio.MultipartFile.fromFile(
            finalData["permis_verso"].path,
            filename: finalData["permis_verso"].name);
      }

      logInfo(finalData.toString());
      var data = dio.FormData.fromMap(finalData);
      logInfo(data.toString());
      var dioResponse =
          await getSingleDio().post(Constants.REGISTER_URL, data: data);
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> jsonResponse = dioResponse.data;
        if (jsonResponse.containsKey("data")) {
          status = WorkStatus.None;
          logSuccess(jsonResponse["data"]);
          loggedStatus = LoggedStatus.None;
          notifyListeners();
          Get.toNamed("/verification");
        }
      }
      status = WorkStatus.None;
      loggedStatus = LoggedStatus.None;
      notifyListeners();
    } on dio.DioError catch (e) {
      status = WorkStatus.Error;
      loggedStatus = LoggedStatus.None;
      notifyListeners();
      Get.snackbar("Une Erreur serveur est survenue", "Veuillez réessayer",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 243, 204, 32));
    }
  }

  Future<void> doUpdateProfile() async {
    status = WorkStatus.LoginIn;
    notifyListeners();
    try {
      final finalData = Map.of(formData);
      logInfo(finalData.toString());

      if (finalData.containsKey("cni_recto")) {
        finalData["cni_recto"] = await dio.MultipartFile.fromFile(
            finalData["cni_recto"].path,
            filename: finalData["cni_recto"].name);
      }

      if (finalData.containsKey("cni_verso")) {
        finalData["cni_verso"] = await dio.MultipartFile.fromFile(
            finalData["cni_verso"].path,
            filename: finalData["cni_verso"].name);
      }

      if (finalData.containsKey("permis_recto")) {
        finalData["permis_recto"] = await dio.MultipartFile.fromFile(
            finalData["permis_recto"].path,
            filename: finalData["permis_recto"].name);
      }
      if (finalData.containsKey("permis_verso")) {
        finalData["permis_verso"] = await dio.MultipartFile.fromFile(
            finalData["permis_verso"].path,
            filename: finalData["permis_verso"].name);
      }
      if (finalData.containsKey("photo")) {
        if (finalData["photo"].length > 0) {
          finalData["photo"] = await dio.MultipartFile.fromFile(
              finalData["photo"][0].path,
              filename: finalData["photo"][0].name);
        }
      }
      if (finalData.containsKey("telephone")) {
        finalData["telephone"] = null;
      }
      if (finalData.containsKey("email")) {
        finalData["email"] = null;
      }

      dio.Options _cacheOptions = buildCacheOptions(const Duration(seconds: 1),
          forceRefresh: true,
          options: dio.Options(
            headers: {
              // set content-length
              'Accept-Charset': "multipart/form-data", // set content-length
            },
          ));

      logInfo(finalData.toString());
      var data = dio.FormData.fromMap(finalData);
      logInfo(data.toString());
      var dioResponse = await getSingleDio()
          .post(Constants.USER_UPDATE_URL, data: data, options: _cacheOptions);
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> jsonResponse = dioResponse.data;
        if (jsonResponse.containsKey("data")) {
          Get.toNamed("/user_profile_page");
        }
        if (jsonResponse.containsKey("errors")) {
          status = WorkStatus.Error;
          notifyListeners();
          logError(jsonResponse["errors"].toString());
          Get.snackbar("Une Erreur serveur est survenue",
              "${jsonResponse["errors"].toString()}",
              colorText: Colors.white,
              backgroundColor: Color.fromARGB(255, 243, 204, 32));
        }
      } else {
        Get.snackbar("ERROR UNKNOWN", "RETRY",
            colorText: Colors.white,
            backgroundColor: Color.fromARGB(255, 243, 204, 32));
      }
      status = WorkStatus.None;
      notifyListeners();
    } on dio.DioError catch (e) {
      status = WorkStatus.Error;
      notifyListeners();
      Get.snackbar("Une Erreur serveur est survenue", "Veuillez réessayer",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 243, 204, 32));
    }
  }

  Future<void> doVerifyAccount(String code) async {
    var prefs = await SharedPreferences.getInstance();
    status = WorkStatus.LoginIn;
    notifyListeners();
    try {
      var data = dio.FormData.fromMap({"verification_code": code});
      var dioResponse =
          await getSingleDio().post(Constants.VERIFY_ACCOUNT_URL, data: data);
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> jsonResponse = dioResponse.data;
        if (jsonResponse.containsKey("token") &&
            jsonResponse.containsKey("data")) {
          status = WorkStatus.None;
          loggedStatus = LoggedStatus.LoggedIn;
          notifyListeners();
          var token = jsonResponse['token'];
          var auth_user = jsonResponse['data'];
          userProfile = UserProfile.fromJson(auth_user);
          debugPrint("[set auth_user started]}");
          await prefs
              .setString("auth_user", convert.jsonEncode(auth_user))
              .catchError((onError) {
            debugPrint("[set auth_user error] ${onError.toString()}");
          });
          await prefs.setString("token", token);
          Get.toNamed("/home");
        } else if (jsonResponse.containsKey("status") &&
            jsonResponse.containsKey("message")) {
          var respStatus = jsonResponse["status"];
          var message = jsonResponse["message"];
          if (respStatus == 401) {
            status = WorkStatus.Error;
            loggedStatus = LoggedStatus.None;
            notifyListeners();
            Get.snackbar("Désolé", "${message}",
                colorText: Colors.white,
                backgroundColor: Color.fromARGB(255, 243, 204, 32));
          }
        }

        if (jsonResponse.containsKey("solde")) {
          var solde = jsonResponse["solde"];
          solde = Solde.fromJson(solde);
          await prefs
              .setString("solde", convert.jsonEncode(solde))
              .catchError((onError) {
            debugPrint("[set solde error] ${onError.toString()}");
          });
        }
      }
    } on dio.DioError catch (e) {
      status = WorkStatus.Error;
      loggedStatus = LoggedStatus.None;
      notifyListeners();
      Get.snackbar("Une Erreur serveur est survenue", "Veuillez réessayer",
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 243, 204, 32));
    }
  }

  Future<void> getUserProfile() async {
    var prefs = await SharedPreferences.getInstance();
    status = WorkStatus.LoginIn;
    notifyListeners();
    try {
      var dioResponse = await getSingleDio().get(Constants.USER_PROFILE_URL);
      if (dioResponse.statusCode == 200) {
        Map<String, dynamic> jsonResponse = dioResponse.data;
        if (jsonResponse.containsKey("authenticated_user")) {
          var userData = jsonResponse["authenticated_user"];
          userProfile = UserProfile.fromJson(userData);
          await prefs
              .setString("auth_user", convert.jsonEncode(userProfile))
              .catchError((onError) {
            debugPrint("[set auth_user error] ${onError.toString()}");
          });
        }
      }
      status = WorkStatus.None;
      notifyListeners();
    } on dio.DioError catch (e) {
      status = WorkStatus.Error;
      notifyListeners();
      debugPrint("Error [User Profile] : ${e.message}");
    }
  }
}
