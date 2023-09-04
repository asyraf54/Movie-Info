
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_info/data/api_service.dart';
import 'package:movie_info/data/movie.dart';
import 'package:movie_info/general_helpers/constant/enum.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  MovieListCubit() : super(MovieListInitial());
  final ApiService apiService = ApiService();
  int page = 1;

  Future<void> getMovie() async {
    if (state is MovieListLoading) return;
    final currentState = state;

    var oldMovies = <Movie>[];
    if (currentState is MovieListLoaded) {
      oldMovies = currentState.movies;
    }

    emit(MovieListLoading(oldMovies, isFirstFetch: page == 1));
    apiService.getMovie(MovieCategory.topRated, page, "en-US").then((newMovies) {
      page++;

      final movies = (state as MovieListLoading).oldMovies;
      movies.addAll(newMovies);

      emit(MovieListLoaded( movies: movies));
    });
  }
}
