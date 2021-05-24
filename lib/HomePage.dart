import 'package:flutter/material.dart';
import 'MoviePage.dart';
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
  List<Movie> _trendingMovies, _popularMovies, _upcomingMovies;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getMovies(Uri.parse(
            'https://api.themoviedb.org/3/trending/movie/day?api_key=ecd787072d3797fe3b24ff3cb23165c5'))
        .then((movies) {
      setState(() {
        _trendingMovies = movies;
        _loading = false;
      });
    });
    Services.getMovies(Uri.parse(
            'https://api.themoviedb.org/3/movie/popular?api_key=ecd787072d3797fe3b24ff3cb23165c5&language=en-US&page=1'))
        .then((movies) {
      setState(() {
        _popularMovies = movies;
        _loading = false;
      });
    });
    Services.getMovies(Uri.parse(
            'https://api.themoviedb.org/3/movie/upcoming?api_key=ecd787072d3797fe3b24ff3cb23165c5&language=en-US&page=1'))
        .then((movies) {
      setState(() {
        _upcomingMovies = movies;
        _loading = false;
      });
    });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
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
              height: 250,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: null == _trendingMovies ? 0 : 5,
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
                                      MoviePage(movie: _trendingMovies[index]),
                                ));
                          },
                          child: Image.network(
                              'https://image.tmdb.org/t/p/w500/' +
                                  _trendingMovies[index].posterPath),
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
              'Popular',
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
                  itemCount: null == _trendingMovies ? 0 : 5,
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
                                      MoviePage(movie: _popularMovies[index]),
                                ));
                          },
                          child: Image.network(
                              'https://image.tmdb.org/t/p/w500/' +
                                  _popularMovies[index].posterPath),
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
            Text(
              'Upcoming',
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
                  itemCount: null == _upcomingMovies ? 0 : 5,
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
                                      MoviePage(movie: _upcomingMovies[index]),
                                ));
                          },
                          child: Image.network(
                              'https://image.tmdb.org/t/p/w500/' +
                                  _upcomingMovies[index].posterPath),
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
    Services.getMovies(Services.url).then((movies) {
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
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: null == _movies ? 0 : 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          Row(children: [
                            // Container(
                            //   height: 180,
                            //   child: Image.network(
                            //       'https://image.tmdb.org/t/p/original/' +
                            //           _movies[index].posterPath),
                            // ),
                            IconButton(
                              icon: Image.network(
                                  'https://image.tmdb.org/t/p/original/' +
                                      _movies[index].posterPath),
                              iconSize: 150,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          MoviePage(movie: _movies[index]),
                                    ));
                              },
                              padding: EdgeInsets.all(0.0),
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
