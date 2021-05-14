import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Movie.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;
  MoviePage({Key key, @required this.movie}) : super(key: key);
  @override
  _MoviePageState createState() => _MoviePageState(this.movie);
}

class _MoviePageState extends State<MoviePage> {
  final Movie movie;
  _MoviePageState(this.movie);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(movie.title),
      // ),
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}
