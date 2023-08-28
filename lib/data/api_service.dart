import 'package:dio/dio.dart';
import 'package:movie_info/data/api_config.dart';
import 'package:movie_info/data/movie.dart';
import 'package:movie_info/general_helpers/config/env.dart';
import 'package:movie_info/general_helpers/constant/enum.dart';

class ApiService {
  final ApiConfig apiConfig = ApiConfig();
  final String apiKey = Env.apiKey;
  final String apiUrlMovie = Env.apiMovieUrl;

  Future<List<Movie>> getMovie(MovieCategory movieCategory) async {
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
      Response response = await apiConfig.getAPI(url: url, params: setParams(1));
      
      List<Movie> movies = (response.data['results'] as List<dynamic>)
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList();

      return movies;
    
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> getDetailMovie(int movieId) async {
    try {
      Response response = await apiConfig.getAPI(
          url: '$apiUrlMovie/$movieId', params: getParams());
      return response.data;
    } catch (error) {
      throw Exception(error);
    }
  }

  Map<String, dynamic> getParams() {
    return {"language": "en-US"};
  }

  Map<String, dynamic> setParams(int page) {
    return {
      "language": "en-US",
      "page": page,
    };
  }
}
