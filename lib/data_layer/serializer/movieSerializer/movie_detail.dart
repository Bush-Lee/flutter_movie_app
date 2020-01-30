import 'package:movie_app/data_layer/serializer/general/genre.dart';
import 'package:movie_app/data_layer/serializer/general/production_companies.dart';
import 'package:movie_app/data_layer/serializer/general/production_countries.dart';
import 'package:movie_app/data_layer/serializer/movieSerializer/movie_videos.dart';

class MovieDetailModel {
  final bool adult;
  final dynamic backdropPath;
  final dynamic belongsToCollection;
  final int budget;
  final List<GenreModel> genres;
  final dynamic homepage;
  final int id;
  final dynamic imdbId;
  final String originalLanguage;
  final String originalTitle;
  final dynamic overview;
  final double popularity;
  final dynamic posterPath;
  final List<ProductionCompaniesModel> productionCompanies;
  final List<ProductionCountriesModel> productionCountries;
  final String releaseDate;
  final int revenue;
  final dynamic runtime;
  final List<String> spokenlanguages;
  final String status;
  final dynamic tagline;
  final String title;
  final bool video;
  final List<Video> videos;
  final double voteAverage;
  final int voteCount;

  MovieDetailModel(
      {this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenlanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
        this.videos,
      this.voteAverage,
      this.voteCount});

  factory MovieDetailModel.fromJson(Map<dynamic, dynamic> json) {
    List<GenreModel> genres = [];
    for (int i=0; i<json["genres"].length; i++) {
      genres.add(GenreModel.fromJson(json["genres"][i]));
    }

    List<Video> videoList = [];
    for (var cv in json["videos"]["results"]) {
      videoList.add(Video.fromJson(cv));
    }

    return MovieDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"]  != null ? "https://image.tmdb.org/t/p/w500" + json["backdrop_path"] : null,
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"],
        genres: genres,
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"],
        posterPath: json["poster_path"] != null ? "https://image.tmdb.org/t/p/w500" + json["poster_path"] : null,
//        productionCompanies: json["production_companies"],
//        productionCountries: json["production_countries"],
        releaseDate: json["release_date"],
        revenue: json["revenue"],
        runtime: json["runtime"],
//        spokenlanguages: json["spoken_languages"],
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        videos: videoList,
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"]);
  }
}
