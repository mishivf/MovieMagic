import 'package:http/http.dart' as http;
import 'Movie.dart';

class Services {
  //
  static Uri url = Uri.parse(
      'https://api.themoviedb.org/3/trending/movie/day?api_key=ecd787072d3797fe3b24ff3cb23165c5');
  static Future<List<Movie>> getMovies() async {
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
}
