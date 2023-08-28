import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_info/data/api_service.dart';
part 'detail_movie_state.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  DetailMovieCubit() : super(DetailMovieInitial());
  final ApiService _apiService = ApiService();

  Future<void> getDetailMovie(int movieId) async {
    emit(DetailMovieLoading());
    try {
      final data = await _apiService.getDetailMovie(movieId);
      emit(DetailMovieLoaded(data: data));
    } catch (error) {
      emit(DetailMovieError(error: 'Failed to fetch data'));
    }
  }
}
