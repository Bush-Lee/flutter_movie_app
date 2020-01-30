import 'package:movie_app/data_layer/serializer/tvShowSerialzier/created_by.dart';
import 'package:movie_app/data_layer/serializer/general/genre.dart';
import 'package:movie_app/data_layer/serializer/tvShowSerialzier/last_episode_to_air.dart';
import 'package:movie_app/data_layer/serializer/general/production_countries.dart';

class TvDetailModel {
  final String backdropPath;
  final List<CreatedByModel> createdBy;
  final List<dynamic> episodeRunTime;
  final String firstAirDate;
  final Genres genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<dynamic> languages;
  final String lastAirDate;
  final LastEpisodeToAirModel lastEpisodeToAir;
  final String title;
  final dynamic nextEpisodeToAir;
  final List<dynamic> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<dynamic> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final dynamic posterPath;
  final List<ProductionCountriesModel> productionCompanies;
  final List<dynamic> seasons;
  final String status;
  final String type;
  final double voteAverage;
  final int voteCount;

  TvDetailModel(
      {this.backdropPath,
      this.createdBy,
      this.episodeRunTime,
      this.firstAirDate,
      this.genres,
      this.homepage,
      this.id,
      this.inProduction,
      this.languages,
      this.lastAirDate,
      this.lastEpisodeToAir,
      this.title,
      this.nextEpisodeToAir,
      this.networks,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.seasons,
      this.status,
      this.type,
      this.voteAverage,
      this.voteCount});

  factory TvDetailModel.fromJson(Map<dynamic, dynamic> json) {
    List<CreatedByModel> createdBy = [];
    for (int i = 0; i < json["created_by"].length; i++) {
      createdBy.add(CreatedByModel.fromJson(json["created_by"][i]));
    }

    return TvDetailModel(
        backdropPath: json["backdrop_path"] != null ? "https://image.tmdb.org/t/p/w500" + json["backdrop_path"] : null,
//        createdBy: json["created_by"],
        createdBy: createdBy,
        episodeRunTime: json["episode_run_time"],
        firstAirDate: json["first_air_date"],
//        genres: json["genres"],
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: json["languages"],
        lastAirDate: json["last_air_date"],
        title: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        networks: json["networks"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: json["origin_country"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"],
        posterPath: json["poster_path"] != null ? "https://image.tmdb.org/t/p/w500" + json["poster_path"] : null,
//        productionCompanies: json["production_companies"],  //TODO: Filter this t
        seasons: json["seasons"],
        status: json["status"],
        type: json["type"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"]);
  }
}
