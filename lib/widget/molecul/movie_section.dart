import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_info/data/movie.dart';
import 'package:movie_info/router/route_name.dart';
import 'package:movie_info/widget/atomic/movie_poster.dart';

class MovieSection extends StatelessWidget {
  final String titleScection;
  final List<Movie> movies;
  final ScrollController controller;
  final bool isLoading;
  const MovieSection(
      {super.key,
      required this.titleScection,
      required this.movies,
      required this.controller,
      required this.isLoading});

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
            const Icon(Icons.arrow_forward_ios, size: 22)
          ],
        ),
        SizedBox(
          height: 270,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            scrollDirection: Axis.horizontal,
            controller: controller,
            itemBuilder: (BuildContext context, int index) {
              if (index < movies.length) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman detail film saat item diklik
                        Navigator.of(context).pushNamed(
                          RouteName.detailListRoute,
                          arguments: movies[index]
                              .id, // Mengirimkan movieId sebagai argumen
                        );
                      },
                      child: MoviePoster(
                          imageUrl:
                              'https://image.tmdb.org/t/p/original${movies[index].posterPath}'),
                    ),
                    Text(movies[index].title),
                  ],
                );
              } else {
                Timer(const Duration(milliseconds: 30), () {
                  controller.jumpTo(controller.position.maxScrollExtent);
                });

                return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()));
              }
            },
            itemCount: movies.length + (isLoading ? 1 : 0),
          ),
        )
      ],
    );
  }
}
