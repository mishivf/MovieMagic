import 'package:flutter/material.dart';
import 'Services.dart';
import 'Movie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 40, 10, 0), child: MovieList()),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        currentIndex: 1,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Watchlist',
          )
        ],
      ),
    );
  }
}

List<String> entries = <String>['A', 'B', 'C'];

class MovieList extends StatefulWidget {
  const MovieList({
    Key key,
  }) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<Result> _movies;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getMovies().then((movies) {
      setState(() {
        _movies = movies;
        _loading = false;
      });
    });
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Trending',
          textScaleFactor: 2.5,
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: null == _movies ? 0 : 3,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Container(
                      height: 150,
                      child: Image.network(
                          'https://image.tmdb.org/t/p/original/' +
                              _movies[index].posterPath),
                    ),
                    SizedBox(
                      width: 5,
                    )
                  ],
                );
              }),
        ),
      ],
    );
  }
}
