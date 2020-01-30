import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


@immutable
abstract class AppState extends Equatable {
  AppState([List props = const []]) : super(props);
}

class HomeUninitialized extends AppState {
  @override
  String toString() => 'PageLoading';
}

class DetailLoading extends AppState {
  @override
  String toString() => 'PageLoading';
}

class HomeLoaded extends AppState {
  final slideshow;
  final posterRoll;
  final genres;

  HomeLoaded({@required this.slideshow, @required this.posterRoll, @required this.genres});

  @override
  String toString() {
    return "Home Page Loaded";
  }

}

class MoviesLoaded extends AppState {
  final trending;
  final popularMovies;
  final genres;
  final inTheathers;
  final comingSoon;
  final topRatedMovies;

  MoviesLoaded({@required this.trending, @required this.popularMovies, @required this.genres, @required this.inTheathers,
    @required this.comingSoon, @required this.topRatedMovies});

  @override
  String toString() => 'Movie Page Loaded';
}

class TvLoaded extends AppState {
  final trending;
  final popularTv;
  final airingToday;
  final genres;


  TvLoaded({@required this.trending, @required this.popularTv, @required this.airingToday, @required this.genres});

  @override
  String toString() => 'Tv Page Loaded';
}

class PosterRollLoaded extends AppState {
  final posterRoll;

  PosterRollLoaded({@required this.posterRoll});

  @override
  String toString() => 'PosterRoll loaded with $posterRoll';
}

class GenresLoaded extends AppState {
  final genres;

  GenresLoaded({@required this.genres});

  @override
  String toString() => 'Genres loaded  with $genres: ';
}

class MovieDetailLoaded extends AppState {
  final movieData;
  final creditsData;
  final images;
  final genres;

  MovieDetailLoaded({@required this.movieData, @required this.creditsData, @required this.images, @required this.genres});

  @override
  String toString() => 'MovieDetail loaded  with $movieData, $creditsData';
}

class TvDetailLoaded extends AppState {
  final tvData;
  final creditsData;
  final images;
  final genres;

  TvDetailLoaded({@required this.tvData, @required this.creditsData, @required this.images, @required this.genres});

  @override
  String toString() => 'MovieDetail loaded  with $tvData, $creditsData';
}

class ListLoaded extends AppState {
  final data;
  final genres;

  ListLoaded({@required this.data, @required this.genres});

  @override
  String toString() => 'list loaded with data: $data ';
}