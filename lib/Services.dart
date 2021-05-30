import 'package:http/http.dart' as http;
import 'Movie.dart';
import 'Genre.dart';

class Services {
  //
  static String movieName;
  static Uri url = Uri.parse(
      'https://api.themoviedb.org/3/trending/movie/day?api_key=ecd787072d3797fe3b24ff3cb23165c5');
  static Uri searchListUrl = Uri.parse(
      'https://api.themoviedb.org/3/search/movie?api_key=ecd787072d3797fe3b24ff3cb23165c5&query=' +
          movieName);
  static Uri popularUrl = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=ecd787072d3797fe3b24ff3cb23165c5&language=en-US&page=1');
  static Uri genreListUrl = Uri.parse(
      'https://api.themoviedb.org/3/genre/movie/list?api_key=ecd787072d3797fe3b24ff3cb23165c5&language=en-US');
  static Future<List<Movie>> getMovies(Uri url) async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final MovieList movies = movieFromJson(response.body);
        return movies.results;
      } else {
        return <Movie>[];
      }
    } catch (e) {
      return <Movie>[];
    }
  }

  static Future<List<Genre>> getGenres(Uri url) async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final GenreList genres = genreListFromJson(response.body);
        return genres.genres;
      } else {
        return <Genre>[];
      }
    } catch (e) {
      return <Genre>[];
    }
  }
}
