import "dart:async";
import 'package:http/http.dart' show Client;
import 'package:movie_app/data_layer/serializer/credits.dart';
import 'package:movie_app/data_layer/serializer/movieSerializer/movie_detail.dart';
import 'package:movie_app/data_layer/serializer/movieSerializer/movie_images.dart';
import 'package:movie_app/data_layer/serializer/movieSerializer/movie_list.dart';
import 'package:movie_app/data_layer/serializer/general/trending.dart';
import 'package:movie_app/data_layer/serializer/tvShowSerialzier/tv_detail.dart';
import 'package:movie_app/data_layer/serializer/tvShowSerialzier/tv_list.dart';
import 'dart:convert';

import 'serializer/general/genre.dart';

class ApiProvider {
  Client client = new Client();
  final _api_key = "8c83a3e4cb7b1a7b30c6982ea8320043";
  final _baseUrl = "http://api.themoviedb.org/3";

  List<dynamic> genres = <dynamic>[];

  Future<List<GenreModel>> fetchGenresList() async {
    try {
      final response =
          await client.get("$_baseUrl/genre/movie/list?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = Genres.fromJson(json.decode(response.body));
        return result.genres;
      } else {
        throw Exception("Something went wrong. Might you try again ? ");
      }
    } catch (e) {
      throw e;
//      throw Exception("Something went wrong please try again");
    }
  }

  Future<List<TrendingModel>> fetchTrending() async {
    try {
      final genres = await fetchGenresList();
      final response =
          await client.get("$_baseUrl/trending/all/week?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = Trending.fromJson(json.decode(response.body), genres);
        return result.trendingModels;
      } else {
        throw Exception("Could not load trending movies");
      }
    } catch (e) {
      throw Exception("Something went wrong please try again");
    }
  }

  // region Movies
  Future<List<TrendingModel>> fetchTrendingMovies() async {
    try {
      final genres = await fetchGenresList();
      final response =
          await client.get("$_baseUrl/trending/movies/week?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = Trending.fromJson(json.decode(response.body), genres);
        return result.trendingModels;
      } else {
        throw Exception("Could not load trending movies");
      }
    } catch (e) {
      throw Exception("Something went wrong please try again");
    }
  }

  Future<List<MovieModelShort>> fetchPopularMovies() async {
    try {
      final genres = await fetchGenresList();
      final response =
          await client.get("$_baseUrl/movie/popular?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = ListMovie.fromJson(json.decode(response.body), genres);
        return result.listMovie;
      } else {
        throw Exception("Could not load popular movies");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<MovieModelShort>> fetchInTheathers() async {
    try {
      final genres = await fetchGenresList();
      final response =
          await client.get("$_baseUrl/movie/now_playing?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = ListMovie.fromJson(json.decode(response.body), genres);
        return result.listMovie;
      } else {
        throw Exception("Could not load nowp playng movies");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<MovieModelShort>> fetchComingSoon() async {
    try {
      final genres = await fetchGenresList();
      final response = await client.get("$_baseUrl/movie/upcoming?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = ListMovie.fromJson(json.decode(response.body), genres);
        return result.listMovie;
      } else {
        throw Exception("Could not load coming soon movies ${response.statusCode}");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<MovieModelShort>> fetchTopRatedMovies() async {
    try {
      final genres = await fetchGenresList();
      final response =
          await client.get("$_baseUrl/movie/top_rated?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = ListMovie.fromJson(json.decode(response.body), genres);
        return result.listMovie;
      } else {
        throw Exception("Could not load top rated movies");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<MovieDetailModel> fetchMovieDetail(int id) async {
    try {
      final response =
          await client.get("$_baseUrl/movie/$id?api_key=$_api_key&append_to_response=videos");
      if (response.statusCode == 200) {
        var result = MovieDetailModel.fromJson(json.decode(response.body));
        return result;
      } else {
        throw Exception("Could not load movie detail");
      }
    } catch (e) {
      throw Exception("Something fishy");
    }
  }

  Future<Credits> fetchMovieCredits(int id) async {
    try {
      final response =
          await client.get("$_baseUrl/movie/$id/credits?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = Credits.fromJson(json.decode(response.body));
        return result;
      } else {
        print(response.statusCode);
        throw Exception("Something fishy");
      }
    } catch (e) {
      throw Exception("Something fishy");
    }
  }

  Future<Images> fetchMovieImages(int id) async {
    try {
      final response =
          await client.get("$_baseUrl/movie/$id/images?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = Images.fromJson(json.decode(response.body));
        return result;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      throw Exception("Something fishy");
    }
  }

  // endregion

  //region TvShow
  Future<List<TvModelShort>> fetchTrendingTv() async {
    try {
      final response =
          await client.get("$_baseUrl/trending/tv/week?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = ListTv.fromJson(json.decode(response.body));
        return result.tvList;
      } else {
        throw Exception("Could not load trending movies");
      }
    } catch (e) {
      throw Exception("Something went wrong please try again");
    }
  }

  Future<List<TvModelShort>> fetchPopularTv() async {
    try {
      final response =
          await client.get("$_baseUrl/tv/popular?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = ListTv.fromJson(json.decode(response.body));
        return result.tvList;
      } else {
        throw Exception("Could not load popular TV movies");
      }
    } catch (e) {
      throw Exception("Something went wrong please try again");
    }
  }

  Future<List<TvModelShort>> fetchAiringToday() async {
    try {
      final response =
          await client.get("$_baseUrl/tv/airing_today?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = ListTv.fromJson(json.decode(response.body));
        return result.tvList;
      } else {
        throw Exception("Could not load airingToday tv movies");
      }
    } catch (e) {
      throw Exception("Something went wrong please try again");
    }
  }

  Future<TvDetailModel> fetchTvDetail(int id) async {
    try {
      final response = await client.get("$_baseUrl/tv/$id?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = TvDetailModel.fromJson(json.decode(response.body));
        return result;
      } else {
        throw Exception("Could not load movie detail");
      }
    } catch (e) {
      throw Exception("Something fishy");
    }
  }

  Future<Images> fetchTvImages(int id) async {
    try {
      final response =
      await client.get("$_baseUrl/tv/$id/images?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = Images.fromJson(json.decode(response.body));
        return result;
      } else {
        print(response.statusCode);
        throw Exception("Something fishy");
      }
    } catch (e) {
      throw Exception("Something fishy");
    }
  }

  Future<Credits> fetchTvCredits(int id) async {
    try {
      final response =
      await client.get("$_baseUrl/tv/$id/credits?api_key=$_api_key");
      if (response.statusCode == 200) {
        var result = Credits.fromJson(json.decode(response.body));
        return result;
      } else {
        print(response.statusCode);
        throw Exception("Something fishy");
      }
    } catch (e) {
      throw Exception("Something fishy");
    }
  }
  //endregion
}
