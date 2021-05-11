// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

Movie movieFromJson(String str) => Movie.fromJson(json.decode(str));

String movieToJson(Movie data) => json.encode(data.toJson());

class Movie {
  Movie({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.id,
    this.video,
    this.voteAverage,
    this.overview,
    this.releaseDate,
    this.voteCount,
    this.title,
    this.popularity,
    this.mediaType,
  });

  bool adult;
  String backdropPath;
  List<int> genreIds;
  OriginalLanguage originalLanguage;
  String originalTitle;
  String posterPath;
  int id;
  bool video;
  double voteAverage;
  String overview;
  DateTime releaseDate;
  int voteCount;
  String title;
  double popularity;
  MediaType mediaType;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        id: json["id"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
        voteCount: json["vote_count"],
        title: json["title"],
        popularity: json["popularity"].toDouble(),
        mediaType: mediaTypeValues.map[json["media_type"]],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "poster_path": posterPath,
        "id": id,
        "video": video,
        "vote_average": voteAverage,
        "overview": overview,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "vote_count": voteCount,
        "title": title,
        "popularity": popularity,
        "media_type": mediaTypeValues.reverse[mediaType],
      };
}

enum MediaType { MOVIE }

final mediaTypeValues = EnumValues({"movie": MediaType.MOVIE});

enum OriginalLanguage { EN, ZH, JA, DE }

final originalLanguageValues = EnumValues({
  "de": OriginalLanguage.DE,
  "en": OriginalLanguage.EN,
  "ja": OriginalLanguage.JA,
  "zh": OriginalLanguage.ZH
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
