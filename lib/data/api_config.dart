import 'dart:developer';

import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_info/general_helpers/config/env.dart';

class ApiConfig {
  ApiConfig() {
    setUpOptions();
  }
  static Alice alice = Alice(
      showNotification: true,
      showInspectorOnShake: true,
      darkTheme: false,
      maxCallsCount: 1000,
      navigatorKey: GlobalKey<NavigatorState>());

  final Dio dio = Dio();
  setUpOptions() async {
    dio.interceptors.add(alice.getDioInterceptor());
  }

  final String apiKey = Env.apiKey;
  final String apiUrlMovie = Env.apiMovieUrl;

  Future<dynamic> getAPI({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      // dio.interceptors.add(alice.getDioInterceptor());
      final response = await dio.get(
        url,
        queryParameters: params,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    } on DioException catch (e) {
      debugPrint("Error: $e");
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
        options: Options(headers: headers),
        data: body,
      );
      return response;
    } on DioException catch (e) {
      // Handle DioError
      log("Error: $e");
      rethrow;
    }
  }
}
