import 'package:flutter/services.dart';
import 'package:movie_app/data_layer/apiProvider.dart';

class Repository {
  final _apiProvider = ApiProvider();

  fetchTrending() => _apiProvider.fetchTrending();

  fetchTrendingMovies() => _apiProvider.fetchTrendingMovies();
  fetchPopularMovies() => _apiProvider.fetchPopularMovies();
  fetchTopRated() => _apiProvider.fetchTopRatedMovies();
  fetchMovieInTheathers() => _apiProvider.fetchInTheathers();
  fetchComingSoon() => _apiProvider.fetchComingSoon();

  fetchMovieDetail(int id) => _apiProvider.fetchMovieDetail(id);
  fetchMovieCredits(int id) => _apiProvider.fetchMovieCredits(id);
  fetchMovieImages(int id) => _apiProvider.fetchMovieImages(id);

  fetchTrendingTv() => _apiProvider.fetchTrendingTv();
  fetchPopularTv() => _apiProvider.fetchPopularTv();
  fetchAiringToday() => _apiProvider.fetchAiringToday();

  fetchTvDetail(int id) => _apiProvider.fetchTvDetail(id);
  fetchTvImages(int id) => _apiProvider.fetchTvImages(id);
  fetchTvCredits(int id) => _apiProvider.fetchTvCredits(id);


  fetchGenres() => _apiProvider.fetchGenresList();
  fetchGenreImgPaths() => genre_paths().then((value) => value);

  Future genre_paths() async {
    var imgFiles = await rootBundle.loadString("assets/images/movie_genre/file_names.txt");
    var imgNames = imgFiles.split("\n");

    List<String> genreNames = [];
    for (int i=0; i < imgNames.length; i++){
      genreNames.add(imgNames[i].split(".")[0]);
    }
    return imgNames;
  }
}

//TwoPasswordAtATime