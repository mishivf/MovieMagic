import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Services.dart';
import 'Movie.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;
  MoviePage({Key key, @required this.movie}) : super(key: key);
  @override
  _MoviePageState createState() => _MoviePageState(this.movie);
}

class _MoviePageState extends State<MoviePage> {
  final Movie movie;
  List<Movie> _similarMovies;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getMovies(Uri.parse('https://api.themoviedb.org/3/movie/' +
            movie.id.toString() +
            '/similar?api_key=ecd787072d3797fe3b24ff3cb23165c5&language=en-US&page=1'))
        .then((movies) {
      setState(() {
        _similarMovies = movies;
        _loading = false;
      });
    });
  }

  _MoviePageState(this.movie);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(movie.title),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                textScaleFactor: 2.5,
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    width: 200,
                    child: Image(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/original/' +
                                movie.posterPath)),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        // Text(
                        //   DateFormat('yyyy-MM-dd').format(movie.releaseDate),
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 20,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                        Text("Rated " +
                            movie.voteAverage.toString() +
                            " by " +
                            movie.voteCount.toString() +
                            " voters"),
                        Text(movie.overview),
                        TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.favorite,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Text(movie.releaseDate.toString()),
              Text(movie.popularity.toString()),
              SizedBox(
                height: 10,
              ),
              Text(
                'Similar',
                textScaleFactor: 2.5,
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: null == _similarMovies ? 0 : 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          // Container(
                          //   child: Image.network(
                          //       'https://image.tmdb.org/t/p/w500/' +
                          //           _movies[index].posterPath),
                          // ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        MoviePage(movie: _similarMovies[index]),
                                  ));
                            },
                            child: Image.network(
                                'https://image.tmdb.org/t/p/w500/' +
                                    _similarMovies[index].posterPath),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
