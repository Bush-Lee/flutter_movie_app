class Images {
  final int id;
  final List<Pictures> backdrops;
  final List<Pictures> posters;

  Images({this.id, this.backdrops, this.posters});

  factory Images.fromJson(Map<dynamic, dynamic> json) {
    List<Pictures> images = [];
    List<Pictures> posters = [];

    for (int i = 0; i < json["backdrops"].length; i++) {
      images.add(Pictures.fromJson(json["backdrops"][i]));
    }

    for (int i = 0; i < json["posters"].length; i++) {
      posters.add(Pictures.fromJson(json["posters"][i]));
    }
    return Images(backdrops: images, posters: posters);
  }
}

class Pictures {
  final double aspectRatio;
  final String path;
  final int height;
  final dynamic iso_639_1;
  final double voteAverage;
  final int voteCount;
  final int width;

  Pictures(
      {this.aspectRatio,
      this.path,
      this.height,
      this.iso_639_1,
      this.voteAverage,
      this.voteCount,
      this.width});

  factory Pictures.fromJson(Map<dynamic, dynamic> json) {
    return Pictures(
        aspectRatio: json["aspect_ratio"] ,
        path: json["file_path"] != null ? "https://image.tmdb.org/t/p/w500" + json["file_path"] : null,
        height: json["height"],
        iso_639_1: json["iso_639_1"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        width: json["width"]);
  }
}


