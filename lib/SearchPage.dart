import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Services.dart';
import 'Movie.dart';
import 'MoviePage.dart';
import 'Genre.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:filter_list/filter_list.dart';

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
  String genre = '';
  List<Genre> _genres = [];
  List<String> _selectedGenres = [];
  List<String> languageName = [], genresName = [];

  @override
  void initState() {
    super.initState();
    _loading = true;
    getMovieList(Services.url);
    Services.getGenres(Uri.parse(
            'https://api.themoviedb.org/3/genre/movie/list?api_key=ecd787072d3797fe3b24ff3cb23165c5&language=en-US'))
        .then((genres) {
      setState(() {
        _genres = genres;
        _loading = false;
      });
      // print(_genres.length);
      for (var item in _genres) {
        genresName.add(item.name);
      }
      print(genresName.length);
    });
  }

  void _openGenreList() async {
    var list = await FilterListDialog.display<String>(
      context,
      listData: genresName,
      height: 450,
      borderRadius: 20,
      headlineText: "Select Genre",
      searchFieldHintText: "Search ",
      choiceChipLabel: (item) {
        return item;
      },
      validateSelectedItem: (list, val) {
        return list.contains(val);
      },
      onItemSearch: (list, text) {
        if (list.any(
            (element) => element.toLowerCase().contains(text.toLowerCase()))) {
          return list
              .where((element) =>
                  element.toLowerCase().contains(text.toLowerCase()))
              .toList();
        } else {
          return [];
        }
      },
      onApplyButtonClick: (list) {
        if (list != null) {
          setState(() {
            _selectedGenres = List.from(list);
            // FIXME: Optimize id search using hashmaps
            for (var s_item in _selectedGenres) {
              for (var g_item in _genres) {
                if (s_item == g_item.name) {
                  genre += g_item.id.toString() + ',';
                  break;
                }
              }
            }
            getMovieList(Uri.parse(
                'https://api.themoviedb.org/3/discover/movie?api_key=ecd787072d3797fe3b24ff3cb23165c5&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate&with_genres=' +
                    genre));
          });
        }
        Navigator.pop(context);
      },
    );

    if (list != null) {
      setState(() {
        _selectedGenres = List.from(list);
      });
    }
  }

  void _openLanguageList() async {
    var list = await FilterListDialog.display<String>(context,
        listData: genresName,
        height: 450,
        borderRadius: 20,
        headlineText: "Select Genre",
        searchFieldHintText: "Search ", choiceChipLabel: (item) {
      return item;
    }, validateSelectedItem: (list, val) {
      return list.contains(val);
    }, onItemSearch: (list, text) {
      if (list.any(
          (element) => element.toLowerCase().contains(text.toLowerCase()))) {
        return list
            .where(
                (element) => element.toLowerCase().contains(text.toLowerCase()))
            .toList();
      } else {
        return [];
      }
    }, onApplyButtonClick: (list) {
      if (list != null) {
        setState(() {
          _selectedGenres = List.from(list);
        });
      }
      Navigator.pop(context);
    });

    if (list != null) {
      setState(() {
        _selectedGenres = List.from(list);
      });
    }
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
            // for (var i = 0; i < _genres.length; i++)
            //   {genresName[i] = _genres[i].name},
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
              height: 5,
            ),
            Row(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 33,
                child: OutlinedButton(
                  onPressed: _openGenreList,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0))),
                  ),
                  child: Text(
                    'language',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 33,
                child: OutlinedButton(
                  onPressed: _openGenreList,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0))),
                  ),
                  child: Text(
                    'genre',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 33,
                child: OutlinedButton(
                  onPressed: _openGenreList,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0))),
                  ),
                  child: Text(
                    'sort by',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 3,
              ),
            ]),
            SizedBox(
              height: 5,
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
