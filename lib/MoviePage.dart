import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('Movie Name'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
        child: Column(
          children: [
            Row(
              children: [
                // Image(
                //   image: NetworkImage(''),
                // ),
                Column(
                  children: [
                    Text(movie.title),
                    Text('cast'),
                    TextButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.favorite,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(''),
            Text(''),
            Text(''),
          ],
        ),
      ),
    );
  }
}
