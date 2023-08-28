
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_info/data/api_service.dart';
import 'package:movie_info/data/movie.dart';
import 'package:movie_info/general_helpers/constant/enum.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  MovieListCubit() : super(MovieListInitial());
  final ApiService _apiService = ApiService();

  Future<void> getMovie() async {
    emit(MovieListLoading());
    try {
      final moviesTopRated = await _apiService.getMovie(MovieCategory.topRated);
      final moviesUpcoming = await _apiService.getMovie(MovieCategory.upcoming);
      emit(MovieListLoaded(moviesTopRated: moviesTopRated,moviesUpcoming: moviesUpcoming));
    } catch (error) {
      emit(MovieListError(error: 'Failed to fetch data'));
    }
  }
}
