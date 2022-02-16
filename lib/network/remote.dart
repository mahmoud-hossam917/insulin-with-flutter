import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://www.postman.com/collections/a8ef27dc9481cefe8017',
        receiveDataWhenStatusError: true));
  }

  static Future<Response> postData(
      {required String url, required Map<String, dynamic> data}) async {
    dynamic ret = await dio?.post(url, data: data);
    return ret;
  }

  static Future<Response> getData(
      {required String url, required Map<String, dynamic> data}) async {
    dynamic ret = await dio?.get(url, queryParameters: data);
    return ret;
  }
}
