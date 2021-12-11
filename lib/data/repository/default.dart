import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'collectorsApi.dart';

Future<Dio> getApiClient() async {

  var _dio = Dio();
  _dio.options.baseUrl = 'http://188.93.211.127:8000/api';

  final storage = new FlutterSecureStorage();


  var token = await storage.read(key: "USER_TOKEN");

  _dio.interceptors.clear();
  _dio.options.headers["Authorization"] = "Token " + token!;
  return _dio;
}

//await storage.write(key: key, value: value);


Future<bool> isTokenValid(String token) async{
  return true;
}