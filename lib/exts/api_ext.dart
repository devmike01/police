import 'dart:convert';

import 'package:dio/dio.dart';


extension DioExt on Dio{
  Future<dynamic> getApi(String path, {Map<String, dynamic>? queryParameters}) async{
    final result = await get(path, queryParameters: queryParameters);

    return jsonDecode(jsonEncode(result.data));
  }
}