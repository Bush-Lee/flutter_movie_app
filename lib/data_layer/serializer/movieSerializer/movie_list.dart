import '../general/genre.dart';

class ListMovie {
  List<MovieModelShort> listMovies;
  ListMovie();

  ListMovie.fromJson(Map<dynamic, dynamic> json, List<GenreModel> genre) {
    List<MovieModelShort> temp = [];
    for (int i = 0; i < json["results"].length; i++) {
      MovieModelShort result = MovieModelShort.fromJson(json["results"][i]);
      temp.add(result);
    }

    listMovies = temp;
  }
  List<MovieModelShort> get listMovie => listMovies;
}

class MovieModelShort {
  final bool video;
  final int voteCount;
  final dynamic voteAverage; // Sometimes flutter reads it as int sometimes as double.
  final String title;
  final String releaseDate;
  final String originalTitle;
  final String originalLanguage;
  final List<dynamic> genreIds;
  final int id;
  final dynamic backdropPath;
  final bool adult;
  final String overview;
  final dynamic posterPath;
  final double popularity;

  MovieModelShort(
      {this.video,
      this.voteCount,
      this.voteAverage,
      this.title,
      this.releaseDate,
      this.originalTitle,
      this.originalLanguage,
      this.genreIds,
      this.id,
      this.backdropPath,
      this.adult,
      this.overview,
      this.posterPath,
      this.popularity
      });

  factory MovieModelShort.fromJson(Map<dynamic, dynamic> json) {

    MovieModelShort model = MovieModelShort(
        video: json["video"],
        voteCount: json["vote_count"],
        voteAverage: json["vote_average"],
        title: json["title"],
        releaseDate: json["release_date"],
        originalTitle: json["original_title"],
        originalLanguage: json["original_language"],
        genreIds: json["genre_ids"],
        id: json["id"],
        backdropPath: json["backdrop_path"]  != null ? "https://image.tmdb.org/t/p/w500" + json["backdrop_path"] : null,
        adult: json["adult"],
        overview: json["overview"],
        posterPath: json["poster_path"] != null ? "https://image.tmdb.org/t/p/w500" + json["poster_path"] : null,
        popularity: json["popularity"]
    );

    return model;
  }
}
