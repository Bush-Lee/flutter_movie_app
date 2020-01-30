class SeasonsModel {
  final String airDate;
  final int episodCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  SeasonsModel(
      {this.airDate,
      this.episodCount,
      this.id,
      this.name,
      this.overview,
      this.posterPath,
      this.seasonNumber});

  factory SeasonsModel.fromJson(Map<dynamic, dynamic> json) {
    return SeasonsModel(
        airDate: json["air_date"],
        episodCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"]);
  }
}
