import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_info/features/detail_movie/cubit/detail_movie_cubit.dart';
import 'package:movie_info/general_helpers/localization/localization.dart';
import 'package:movie_info/widget/atomic/backdrop_image.dart';
import 'package:movie_info/widget/atomic/movie_poster.dart';

class DetailMovie extends StatelessWidget {
  final int movieId;

  // ignore: use_key_in_widget_constructors
  const DetailMovie({required this.movieId});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            // TRY THIS: Try changing the color here to a specific color (to
            // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
            // change color while the other colors stay the same.
            backgroundColor: const Color.fromARGB(255, 2, 5, 42),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title:  Text(
              translation(context).detailTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          body: BlocBuilder<DetailMovieCubit, DetailMovieState>(
            builder: (context, state) {
              if (state is DetailMovieLoaded) {
                // Tampilkan detail movie berdasarkan state LoadedMovieDetail
                final movie = state.data;
                final genres = movie['genres'];

                return SingleChildScrollView(
                    child: Column(children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      BackDrop(
                          imageUrl:
                              'https://image.tmdb.org/t/p/original${movie['backdrop_path']}'),
                      Positioned.fill(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: MoviePoster(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original${movie['poster_path']}')),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        movie['title'],
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: double
                        .infinity, // Ensure the container takes up full width
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: genres.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(genres[index]['name'] + " ",
                              style: const TextStyle(fontSize: 20));
                        },
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        movie['overview'],
                        textAlign: TextAlign.justify,
                      ))
                ]));
              } else if (state is DetailMovieLoading) {
                // Tampilkan widget loading
                return const Center(child: CircularProgressIndicator());
              } else if (state is DetailMovieError) {
                // Tampilkan pesan error
                return const Text('Error loading movie detail');
              } else {
                return const Text(
                    'BELUM DIPANGGIL'); // Handle state lain jika diperlukan
              }
            },
          ),
        );
  }
}
