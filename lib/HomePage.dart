import 'package:flutter/material.dart';
import 'SearchPage.dart';
import 'Services.dart';
import 'Movie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _children = [
    SearchWidget(),
    MovieListWidget(),
    SearchWidget()
  ];
  int _currentIndex = 1;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
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

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({
    Key key,
  }) : super(key: key);

  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  List<Movie> _movies;
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
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Trending',
            textScaleFactor: 2.5,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
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
                        child: Image.network(
                            'https://image.tmdb.org/t/p/original/' +
                                _movies[index].posterPath),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
