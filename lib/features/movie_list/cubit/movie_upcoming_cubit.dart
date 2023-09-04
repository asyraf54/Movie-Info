
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_info/data/api_service.dart';
import 'package:movie_info/data/movie.dart';
import 'package:movie_info/general_helpers/constant/enum.dart';

part 'movie_upcoming_state.dart';

class MovieUpcomingCubit extends Cubit<MovieUpcomingState> {
  MovieUpcomingCubit(this.apiService)  : super(MovieUpcomingInitial());
  final ApiService apiService;

  int page = 1;

  Future<void> getMovie() async {
    if (state is MovieUpcomingLoading) return;
    final currentState = state;

    var oldMovies = <Movie>[];
    if (currentState is MovieUpcomingLoaded) {
      oldMovies = currentState.movies;
    }

    emit(MovieUpcomingLoading(oldMovies, isFirstFetch: page == 1));
    apiService.getMovie(MovieCategory.upcoming, page, "en-US").then((newMovies) {
      page++;

      final movies = (state as MovieUpcomingLoading).oldMovies;
      movies.addAll(newMovies);

      emit(MovieUpcomingLoaded(movies));
    });
  }
}
