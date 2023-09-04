import 'package:dio/dio.dart';
import 'package:movie_info/data/api_config.dart';
import 'package:movie_info/data/movie.dart';
import 'package:movie_info/general_helpers/config/env.dart';
import 'package:movie_info/general_helpers/constant/enum.dart';

class ApiService {
  final ApiConfig apiConfig = ApiConfig();
  final String apiKey = Env.apiKey;
  final String apiUrlMovie = Env.apiMovieUrl;

  // Future<List<Movie>> getMovieTop() async {
  //   try {
  //     final  url = '$apiUrlMovie/top_rated';
  //     Response response = await apiConfig.getAPI(
  //         url: url, params: setParams(1), headers: getHeaders());

  //     List<Movie> movies = (response.data['results'] as List<dynamic>)
  //         .map((movieJson) => Movie.fromJson(movieJson))
  //         .toList();

  //     return movies;
  //   } catch (error) {
  //     throw Exception(error);
  //   }
  // }
  // Future<List<Movie>> getMovieUp() async {
  //   try {
  //     final  url = '$apiUrlMovie/upcoming';
  //     Response response = await apiConfig.getAPI(
  //         url: url, params: setParams(1), headers: getHeaders());

  //     List<Movie> movies = (response.data['results'] as List<dynamic>)
  //         .map((movieJson) => Movie.fromJson(movieJson))
  //         .toList();

  //     return movies;
  //   } catch (error) {
  //     throw Exception(error);
  //   }
  // }
  Future<List<Movie>> getMovie(MovieCategory movieCategory, int page, String language) async {
    String url;
    switch (movieCategory) {
      case MovieCategory.topRated:
        url = '$apiUrlMovie/top_rated';
        break;
      case MovieCategory.nowPlaying:
        url = '$apiUrlMovie/now_playing';
        break;
      case MovieCategory.popular:
        url = '$apiUrlMovie/popular';
        break;
      case MovieCategory.upcoming:
        url = '$apiUrlMovie/upcoming';
        break;
    }

    try {
      // apiConfig.dio.interceptors.clear();
      Response response = await apiConfig.getAPI(
          url: url, params: setParams(page, language), headers: getHeaders());
      // apiConfig.dio.interceptors.add(ApiConfig.alice.getDioInterceptor());
      List<Movie> movies = (response.data['results'] as List<dynamic>)
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList();

      return movies;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> getDetailMovie(int movieId, String language) async {
    try {
      Response response = await apiConfig.getAPI(
          url: '$apiUrlMovie/$movieId',
          params: setDetailParams(language),
          headers: getHeaders());
      return response.data;
    } catch (error) {
      throw Exception(error);
    }
  }

  Map<String, dynamic> setDetailParams(String language) {
    return {"language": language};
  }

  Map<String, dynamic> setParams(int page, String language) {
    return {
      "language": language,
      "page": page,
    };
  }

  Map<String, dynamic> getHeaders() {
    return {
      "accept": "application/json",
      "Authorization": "Bearer $apiKey",
    };
  }
}
