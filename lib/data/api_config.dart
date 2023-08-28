import 'dart:developer';

import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:movie_info/general_helpers/config/env.dart';

class ApiConfig {
  static Alice alice = Alice(
    showNotification: true,
    showInspectorOnShake: true,
    darkTheme: false,
    maxCallsCount: 1000,
  );
  
  final Dio dio = Dio();
  final String apiKey = Env.apiKey;
  final String apiUrlMovie = Env.apiMovieUrl;

  Future<Response> getAPI({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      dio.interceptors.add(alice.getDioInterceptor());
      final response = await dio.get(
        url,
        queryParameters: params,
        options: Options(headers: getHeaders()),
      );
      return response;
    } on DioException catch (e) {
      log("Error: $e");
      rethrow;
    }
  }

  Future<Response> postAPI({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    try {
      dio.interceptors.add(alice.getDioInterceptor());
      final response = await dio.post(
        url,
        queryParameters: params,
        options: Options(headers: getHeaders()),
        data: body,
      );
      return response;
    } on DioException catch (e) {
      // Handle DioError
      log("Error: $e");
      rethrow;
    }
  }

  Map<String, dynamic> getHeaders() {
    return {
      "accept": "application/json",
      "Authorization": "Bearer $apiKey",
    };
  }
}
