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
    WishlistWidget(),
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
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
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
                itemCount: null == _movies ? 0 : 5,
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
          SizedBox(
            height: 15,
          ),
          Text(
            'New Releases',
            textScaleFactor: 2.5,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({
    Key key,
  }) : super(key: key);

  @override
  _WishlistWidgetState createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {
  List<Movie> _movies;
  bool _loading;
  Color favButtonColor;

  void onIconTapped() {
    setState(() {
      if (favButtonColor == Colors.red) {
        favButtonColor = Colors.grey;
      } else {
        favButtonColor = Colors.red;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getMovies().then((movies) {
      setState(() {
        _movies = movies;
        _loading = false;
        favButtonColor = Colors.red;
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
            'Wishlist',
            textScaleFactor: 2.5,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              height: 400,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: null == _movies ? 0 : 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          Row(children: [
                            Container(
                              height: 180,
                              child: Image.network(
                                  'https://image.tmdb.org/t/p/original/' +
                                      _movies[index].posterPath),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: 200,
                                    child: Text(
                                      _movies[index].title,
                                      textScaleFactor: 1.2,
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      _movies[index].overview,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite),
                              color: favButtonColor,
                              onPressed: onIconTapped,
                            )
                          ]),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
