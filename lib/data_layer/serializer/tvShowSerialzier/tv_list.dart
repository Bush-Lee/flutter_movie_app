import 'package:flutter/material.dart';

class ListTv {
  List<TvModelShort> tvList;

  ListTv.fromJson(Map<dynamic, dynamic> json) {
    List<TvModelShort> temp = [];

    for (int i = 0; i <= json["results"].length - 1; i++) {
      TvModelShort result = TvModelShort.fromJson(json["results"][i]);
      temp.add(result);
    }
    tvList = temp;
  }
}

class TvModelShort {
  final dynamic posterPath; //x
  final bool adult;
  final String overview; //x
  final String firstAirDate; //x
  final List<dynamic> genreId; //x
//  final List<dynamic> genres; //x
  final int id; //x
  final List<dynamic> originCountry; //x
  final String originalLanguage; //x
  final String title; //x
  final dynamic backdropPath; //x
  final dynamic popularity; //x
  final dynamic voteCount; //x
  final dynamic voteAverage; //x

  TvModelShort({
    this.posterPath,
    this.adult,
    this.overview,
    this.firstAirDate,
    this.genreId,
    this.id,
    this.originCountry,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.voteAverage,
  });

  factory TvModelShort.fromJson(Map<dynamic, dynamic> json) {
    return TvModelShort(
        posterPath: json["poster_path"] != null ? "https://image.tmdb.org/t/p/w500" + json["poster_path"] : null,
        adult: json["adult"],
        overview: json["overview"],
        firstAirDate: json["first_air_date"],
        genreId: json["genre_ids"],
        id: json["id"],
        originCountry: json["origin_country"],
        originalLanguage: json["original_language"],
        title: json["name"],
        backdropPath: json["backdrop_path"] != null ? "https://image.tmdb.org/t/p/w500" + json["backdrop_path"] : null,
        popularity: json["popularity"],
        voteCount: json["vote_count"],
        voteAverage: json["vote_average"]);
  }
}
