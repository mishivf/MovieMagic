// To parse this JSON data, do
//
//     final genreList = genreListFromJson(jsonString);

import 'dart:convert';

GenreList genreListFromJson(String str) => GenreList.fromJson(json.decode(str));

String genreListToJson(GenreList data) => json.encode(data.toJson());

class GenreList {
  GenreList({
    this.genres,
  });

  List<Genre> genres;

  factory GenreList.fromJson(Map<String, dynamic> json) => GenreList(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
