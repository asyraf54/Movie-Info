part of 'movie_list_cubit.dart';

@immutable
sealed class MovieListState {}

final class MovieListInitial extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListLoaded extends MovieListState {
  final List<Movie> moviesTopRated;
  final List<Movie> moviesUpcoming;
  MovieListLoaded({required this.moviesTopRated, required this.moviesUpcoming});
}

class MovieListError extends MovieListState {
  final String error;
  MovieListError({required this.error});
}
