part of 'movie_list_cubit.dart';

@immutable
abstract class MovieListState {}

final class MovieListInitial extends MovieListState {}

class MovieListLoading extends MovieListState {
  final List<Movie> oldMovies;
  final bool isFirstFetch;
  MovieListLoading(this.oldMovies, {this.isFirstFetch = false});
}

class MovieListLoaded extends MovieListState {
  final List<Movie> movies;
  MovieListLoaded({required this.movies});
}

class MovieListError extends MovieListState {
  final String error;
  MovieListError({required this.error});
}
