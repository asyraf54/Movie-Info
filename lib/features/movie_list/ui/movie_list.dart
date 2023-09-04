import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_info/data/movie.dart';
import 'package:movie_info/features/movie_list/cubit/movie_list_cubit.dart';
import 'package:movie_info/features/movie_list/cubit/movie_upcoming_cubit.dart';
import 'package:movie_info/general_helpers/localization/language.dart';
import 'package:movie_info/main.dart';
import 'package:movie_info/widget/atomic/custom_loading.dart';
import 'package:movie_info/widget/atomic/logo.dart';
import 'package:movie_info/widget/molecul/movie_section.dart';
import 'package:movie_info/general_helpers/localization/localization.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  void _setLocale(Locale locale) {
    setState(() {
      MyApp.setLocale(context, locale);
    });
  }

  final topRatedController = ScrollController();
  final upcomingController = ScrollController();

  void setupScrollController(context) {
    topRatedController.addListener(() {
      if (topRatedController.position.atEdge) {
        if (topRatedController.position.pixels != 0) {
          BlocProvider.of<MovieListCubit>(context).getMovie();
        }
      }
    });
    upcomingController.addListener(() {
      if (upcomingController.position.atEdge) {
        if (upcomingController.position.pixels != 0) {
          BlocProvider.of<MovieUpcomingCubit>(context).getMovie();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: const Color.fromARGB(255, 2, 5, 42),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Logo(isCenter: false),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Language>(
                underline: const SizedBox(),
                icon: const Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                onChanged: (Language? language) async {
                  if (language != null) {
                    Locale locale = await setLocale(language.languageCode);
                    _setLocale(locale);
                  }
                },
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              e.languageCode,
                              style: const TextStyle(fontSize: 30),
                            ),
                            Text(e.name)
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 35),
                child: Image.asset(
                  'assets/Navy.jpg',
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
              const Logo(isCenter: true)
              //     Positioned(bottom: 0,left: 0,
              // right: 0, child: imageSection)
            ],
          ),
          BlocBuilder<MovieListCubit, MovieListState>(
              builder: (context, state) {
            if (state is MovieListLoading && state.isFirstFetch) {
              return const CustomLoading();
            }
            List<Movie> movies = [];
            bool isLoading = false;

            if (state is MovieListLoading) {
              movies = state.oldMovies;
              isLoading = true;
            } else if (state is MovieListLoaded) {
              movies = state.movies;
            }
            if (movies.isNotEmpty) {
              return MovieSection(
                  titleScection: translation(context).topRatedTitle,
                  movies: movies,
                  controller: topRatedController,
                  isLoading: isLoading);
            } else {
              return const Center(
                child: Text('No movies available.'),
              );
            }
          }),
          BlocBuilder<MovieUpcomingCubit, MovieUpcomingState>(
              builder: (context, state) {
            if (state is MovieUpcomingLoading && state.isFirstFetch) {
              return const CustomLoading();
            }
            List<Movie> movies = [];
            bool isLoading = false;

            if (state is MovieUpcomingLoading) {
              movies = state.oldMovies;
              isLoading = true;
            } else if (state is MovieUpcomingLoaded) {
              movies = state.movies;
            }
            if (movies.isNotEmpty) {
              return MovieSection(
                  titleScection:  translation(context).upcomingTitle,
                  movies: movies,
                  controller: upcomingController,
                  isLoading: isLoading);
            } else {
              return const Center(
                child: Text('No movies available.'),
              );
            }
          })
        ])));
  }
}
