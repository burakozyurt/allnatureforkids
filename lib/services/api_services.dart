import 'dart:convert';

import 'package:allnatureforkids/services/http_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class ApiService {
  ApiService._instances();

  static final ApiService instances = ApiService._instances();

  static String usernameKey = 'loginID';
  static String username;

  Future<bool> createUserAuthentication(dynamic body) async {
    Response response = await HttpUtils.postRequestNew('register', body);
    if (response.statusCode == 201) {
      return true;
    } else {
      print(response.body);
      return false;
    }
  }



  Future<String> getUserNameFromLocal() async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    String jwt = await storage.read(key: ApiService.usernameKey);
    if (jwt != null) {
      return jwt;
    } else {
      return null;
    }
  }
  Future<String> saveUserNameToLocal(String loginName) async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    await storage.write(key: ApiService.usernameKey,value: loginName);
  }


}
