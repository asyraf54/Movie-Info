// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static String apiKey = _Env.apiKey;

  @EnviedField(varName: 'API_MOVIE_URL', obfuscate: true)
  static String apiMovieUrl = _Env.apiMovieUrl;
}
