import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_info/data/api_service.dart';
import 'package:movie_info/features/detail_movie/cubit/detail_movie_cubit.dart';
import 'package:movie_info/features/detail_movie/ui/detail_movie.dart';
import 'package:movie_info/features/movie_list/cubit/movie_list_cubit.dart';
import 'package:movie_info/features/movie_list/cubit/movie_upcoming_cubit.dart';
import 'package:movie_info/features/movie_list/ui/movie_list.dart';
import 'package:movie_info/features/not_found/not_found_page.dart';
import 'package:movie_info/router/route_name.dart';

class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    final args = settings.arguments; // Menerima argumen dari rute jika ada
    final ApiService apiService = ApiService();
    switch (settings.name) {
      case RouteName.movieListRoute:
        return MaterialPageRoute(
            // builder: (context) => const MovieListPage(
            //             title: "GG"),
            builder: (context) => MultiBlocProvider(
                    providers: [
                      // BlocProvider(
                      //     create: (context) => MovieListCubit()..getMovieUpcoming()..getMovie()),

                      BlocProvider(
                          create: (context) => MovieListCubit()..getMovie()),
                      BlocProvider(
                          create: (context) =>
                              MovieUpcomingCubit(apiService)..getMovie()),
                    ],
                    child: const MovieListPage(
                        title: "GG")) // Gantilah dengan Bloc atau Cubit Anda

            );

      case RouteName.detailListRoute:
        if (args is int) {
          // Pastikan bahwa args adalah tipe data yang sesuai (int)
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => DetailMovieCubit()
                ..getDetailMovie(args), // Gantilah dengan Bloc atau Cubit Anda
              child: DetailMovie(
                  movieId:
                      args), // Mengirimkan movieId sebagai argumen ke halaman detail
            ),
          );
        } else {
          // Penanganan jika args tidak sesuai
          return MaterialPageRoute(
            builder: (context) => const NotFoundPage(),
          );
        }
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundPage(),
        );
    }
  }
}
