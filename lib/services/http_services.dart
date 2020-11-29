import 'dart:convert' show Encoding, utf8;
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpUtils {
  static String errorHeader = 'x-savekids-error';
  static String successResult = 'success';
  static String keyForJWTToken = 'jwt-token';
  static String _baseUrl = '3.137.147.111:3000';

  static FlutterSecureStorage storage = new FlutterSecureStorage();
  static String encodeUTF8(String toEncode) {
    return utf8.decode(toEncode.runes.toList());
  }

  static Future<Object> headers() async {
    String jwt = await storage.read(key: HttpUtils.keyForJWTToken);
    if (jwt != null) {
      return {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      };
    } else {
      return {'Content-Type': 'application/json',
        'Cookie': 'connect.sid=s%3AuD_oE7vIQnLvIKSS0MdwvKQ3QftF01l5.WbMxdVE%2FRM7r1uxW6Y7eLk8wS5yv3WeCM42786TALzI'
      };
    }
  }

  static saveJwtToken(String token) async {
    String jwt = token;
    storage.write(key: HttpUtils.keyForJWTToken, value: jwt);
  }

  static delete(String token) async {
    storage.delete(key: HttpUtils.keyForJWTToken,);
  }

  static Future<Response> postRequest<T>(String endpoint, T body) async {
    var headers = await HttpUtils.headers();
   // final String json = JsonMapper.serialize(body, SerializationOptions(indent: ''));
    String subsUrl = endpoint;
    Uri uri = Uri.http(Uri.encodeFull(_baseUrl), subsUrl);
    return await http.post(uri,  body: json.encode(body), encoding: Encoding.getByName('utf-8'));
  }

  //BU kullanılmaktadır
  static Future<Response> postRequestNew<T>(
      String endpoint, Map<dynamic, dynamic> body) async {
    var headers = await HttpUtils.headers();

    String subsUrl =  endpoint;
    Uri uri = Uri.http(Uri.encodeFull(_baseUrl), subsUrl);

    var response =
        await http.post(uri, headers: headers, body: json.encode(body));
    return response;
    if (response.statusCode == 200) {
      return response;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  static Future<Response> getRequest(String endpoint) async {
    var headers = await HttpUtils.headers();
    String subsUrl = 'api/' + endpoint;
    Uri uri = Uri.https(Uri.encodeFull(_baseUrl), subsUrl);

    return await http.get(uri, headers: headers);
  }

  static Future<Response> getRequestParams(String endpoint,Map<String,String> params) async {
    var headers = await HttpUtils.headers();
    String subsUrl = 'api/' + endpoint;
    Uri uri = Uri.https(Uri.encodeFull(_baseUrl), subsUrl,params);

    return await http.get(uri, headers: headers);
  }
}
