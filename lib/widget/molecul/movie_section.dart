import 'package:flutter/material.dart';
import 'package:movie_info/data/movie.dart';
import 'package:movie_info/router/route_name.dart';
import 'package:movie_info/widget/atomic/movie_poster.dart';

class MovieSection extends StatelessWidget {
  final String titleScection;
  final List<Movie> movies;
  const MovieSection(
      {super.key, required this.titleScection, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                titleScection,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size:22
            )
          ],
        ),
        SizedBox(
          height: 270,
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman detail film saat item diklik
                        Navigator.of(context).pushNamed(
      RouteName.detailListRoute,
      arguments: movies[index].id, // Mengirimkan movieId sebagai argumen
    );
                      },
                      child: MoviePoster(
                          imageUrl:
                              'https://image.tmdb.org/t/p/original${movies[index].posterPath}'),
                    ),
                    Text(movies[index].title),
                  ],
                );
              }),
        )
      ],
    );
  }
}
