import 'genre.dart';

class Trending {
  List<TrendingModel> _trendingModels;
  Trending();

  Trending.fromJson(Map<dynamic, dynamic> json, List<GenreModel> genre) {
    List<TrendingModel> temp = [];

    for (int i = 0; i <= 16; i++) {
      TrendingModel result = TrendingModel.fromJson(json["results"][i], genre);
      temp.add(result);
    }
    _trendingModels = temp;
  }
  List<TrendingModel> get trendingModels => _trendingModels;
}

class TrendingModel {
  final dynamic posterPath;
  final bool adult;
  final String overview;
  final String releaseDate;
  final List<dynamic> genreId;
//  final List<dynamic> genres;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final dynamic backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;
  final bool isMovie;

  TrendingModel(
      {this.posterPath,
      this.adult,
      this.overview,
      this.releaseDate,
      this.genreId,
      this.id,
      this.originalTitle,
      this.originalLanguage,
      this.title,
      this.backdropPath,
      this.popularity,
      this.voteCount,
      this.video,
      this.voteAverage,
      this.isMovie});

  factory TrendingModel.fromJson(
      Map<dynamic, dynamic> json, List<GenreModel> genres) {

    var model = TrendingModel(
      posterPath: json["poster_path"] != null
          ? "https://image.tmdb.org/t/p/w500" + json["poster_path"]
          : null,
      adult: json["adult"],
      overview: json["overview"],
      releaseDate: json["release_date"] != null
          ? json["release_date"]
          : json["first_air_date"],
      genreId: json["genre_ids"],
      id: json["id"],
      originalTitle: json["original_title"],
      originalLanguage: json["original_language"],
      title: json["title"] != null ? json["title"] : json["name"],
      backdropPath: json["backdrop_path"] != null
          ? "https://image.tmdb.org/t/p/w500" + json["backdrop_path"]
          : null,
      popularity: json["popularity"],
      voteCount: json["vote_count"],
      video: json["video"],
      voteAverage: json["vote_average"],
      isMovie: json["release_date"] != null ? true : false,
    );
    return model;
  }
}
