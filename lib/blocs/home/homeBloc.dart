import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movie_app/data_layer/repository.dart';
import 'package:movie_app/data_layer/serializer/movieSerializer/movie_list.dart';
import 'package:movie_app/data_layer/serializer/general/trending.dart';
import 'package:movie_app/data_layer/serializer/tvShowSerialzier/tv_list.dart';

import 'homeEvent.dart';
import 'homeState.dart';

class HomeBloc extends Bloc<AppEvent, AppState> {
  Repository repo = Repository();

  @override
  AppState get initialState => HomeUninitialized();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    var trending = await repo.fetchTrendingMovies();
    var popularMovies = await repo.fetchPopularMovies();
    var genres = await repo.fetchGenreImgPaths();

    if (trending != null && genres != null && popularMovies != null) {
      yield HomeLoaded(
          genres: genres, posterRoll: popularMovies, slideshow: trending);
    }

    if (event is MovieStarted) {
      var genres = await repo.fetchGenreImgPaths();
      var popularMovies = await repo.fetchPopularMovies();
      var inTheathers = await repo.fetchMovieInTheathers();
      var trending = await repo.fetchTrendingMovies();
      var comingSoon = await repo.fetchComingSoon();
      var topRated = await repo.fetchTopRated();

      yield MoviesLoaded(genres: genres, popularMovies: popularMovies, comingSoon: comingSoon, inTheathers: inTheathers, trending: trending, topRatedMovies: topRated);
    }

    if (event is TvStarted){
      var trending = await repo.fetchTrendingTv();
      var popularTv = await repo.fetchPopularTv();
      var airingToday = await repo.fetchAiringToday();
      var genres = await repo.fetchGenreImgPaths();

      yield TvLoaded(trending: trending, popularTv: popularTv, airingToday: airingToday, genres: genres);
    }

    if (event is DetailRequest) {
      if (event.data is TrendingModel) {
        if (event.data.isMovie) {
          var movieDetail = await repo.fetchMovieDetail(event.data.id);
          var movieCast = await repo.fetchMovieCredits(event.data.id);
          var movieImages = await repo.fetchMovieImages(event.data.id);
          var genres = await repo.fetchGenres();

          yield MovieDetailLoaded(movieData: movieDetail, creditsData: movieCast, images: movieImages, genres: genres);
        } else  if (event.data.isMovie != true){
          var tvDetail = await repo.fetchTvDetail(event.data.id);
          var tvImages = await repo.fetchTvImages(event.data.id);
          var tvCredits = await repo.fetchTvCredits(event.data.id);
          var genres = await repo.fetchGenreImgPaths();

          yield TvDetailLoaded(creditsData: tvCredits, images: tvImages, genres: genres, tvData: tvDetail);
        }
      }

      if (event.data is MovieModelShort) {
        var movieDetail = await repo.fetchMovieDetail(event.data.id);
        var movieCast = await repo.fetchMovieCredits(event.data.id);
        var movieImages = await repo.fetchMovieImages(event.data.id);
        var genres = await repo.fetchGenreImgPaths();

        yield MovieDetailLoaded(movieData: movieDetail, creditsData: movieCast, images: movieImages, genres: genres);
      }

      if (event.data is TvModelShort) {
        var tvDetail = await repo.fetchTvDetail(event.data.id);
        var tvImages = await repo.fetchTvImages(event.data.id);
        var tvCredits = await repo.fetchTvCredits(event.data.id);
        var genres = await repo.fetchGenreImgPaths();

        yield TvDetailLoaded(creditsData: tvCredits, images: tvImages, genres: genres, tvData: tvDetail);
      }
    }

    if (event is ListStarted) {
      var genres = await repo.fetchGenres();
      if (event.type.contains("M")){
        switch (event.type[1]) {
          case "P": {
            var moviePopular = await repo.fetchPopularMovies();
            yield ListLoaded(data: moviePopular, genres: genres);
          }
          break;
          case "T": {
            var inTheathers = await repo.fetchMovieInTheathers();
            yield ListLoaded(data: inTheathers, genres: genres);
          }
          break;
          case "S": {
            var comingSoon = await repo.fetchComingSoon();
            yield ListLoaded(data: comingSoon, genres: genres);
          }
          break;
          case "R": {
            var topRated = await repo.fetchTopRated();
            yield ListLoaded(data: topRated, genres: genres);
          }
//          break;
//          case "G" {
//
//          }
        }
      }
      if (event.type.contains("TV")){
        switch (event.type[2]) {
          case "P":
            {
              var popularTv = await repo.fetchPopularTv();
              yield ListLoaded(data: popularTv, genres: genres);
            }
            break;
          case "A":
            {
              var airingToday = await repo.fetchAiringToday();
              yield ListLoaded(data: airingToday, genres: genres);
            }
            break;
//        case "G" {
//
//        }
        }
      }
    }

    if (event is SearchStarted) {
      var genres = await repo.fetchGenres();
      yield SearchLoaded(genres: genres);
    }

    if (event is GetSearchResults) {
      var results = await repo.fetchSearch(event.searchParams);
      var genres = await repo.fetchGenres();
      yield GotSearchResult(searchResults: results);
    }
  }
}
