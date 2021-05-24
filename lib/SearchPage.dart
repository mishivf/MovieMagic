import 'package:flutter/material.dart';
import 'Services.dart';
import 'Movie.dart';
import 'MoviePage.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key key,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List<Movie> _movies;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    getMovieList(Services.url);
  }

  void getMovieList(Uri url) {
    Services.getMovies(url).then((movies) {
      setState(() {
        _movies = movies;
        _loading = false;
      });
    });
  }

  var myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Services.movieName = myController.text;
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search movies',
              ),
              onChanged: (text) => setState(() => getMovieList(Uri.parse(
                  'https://api.themoviedb.org/3/search/movie?api_key=ecd787072d3797fe3b24ff3cb23165c5&query=' +
                      text))),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: null == _movies ? 0 : 15,
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
        ));
  }
}
