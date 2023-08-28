part of 'detail_movie_cubit.dart';

@immutable
sealed class DetailMovieState {}

final class DetailMovieInitial extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieLoaded extends DetailMovieState {
  final Map<String, dynamic> data;
  DetailMovieLoaded({required this.data});
}

class DetailMovieError extends DetailMovieState {
  final String error;
  DetailMovieError({required this.error});
}
