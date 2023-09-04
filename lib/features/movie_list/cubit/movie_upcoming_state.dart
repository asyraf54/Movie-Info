part of 'movie_upcoming_cubit.dart';

@immutable
abstract class MovieUpcomingState {}

class MovieUpcomingInitial extends MovieUpcomingState {}
class MovieUpcomingLoaded extends MovieUpcomingState {
  final List<Movie> movies;

  MovieUpcomingLoaded(this.movies);
}

class MovieUpcomingLoading extends MovieUpcomingState {
  final List<Movie> oldMovies;
  final bool isFirstFetch;

  MovieUpcomingLoading(this.oldMovies, {this.isFirstFetch=false});
}