import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/home/homeBloc.dart';
import 'package:movie_app/blocs/home/homeEvent.dart';
import 'package:movie_app/blocs/home/homeState.dart';

import 'package:movie_app/ui/general/posterRoll.dart';
import 'package:movie_app/ui/general/slideshow.dart';
import 'package:movie_app/ui/general/genre.dart';

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      builder: (context) => HomeBloc()
        ..dispatch(MovieStarted()),
      child: MovieWidget(),
    );
  }
}

class MovieWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<AppEvent, AppState>(
      bloc: homeBloc,
      builder: (BuildContext context, AppState state){
        Widget trending = Center(child: CircularProgressIndicator());
        Widget popularMovies = Center(child: CircularProgressIndicator());
        Widget genres = Center(child: CircularProgressIndicator());
        Widget inTheathers = Center(child: CircularProgressIndicator());
        Widget comingSoon = Center(child: CircularProgressIndicator());
        Widget topRatedMovies = Center(child: CircularProgressIndicator());

        if (state is MoviesLoaded) {
          trending = Slideshow(data: state.trending,);
          popularMovies = PosterRoll(data: state.popularMovies, title: "Most Popular Movies"); //X
          inTheathers = PosterRoll(data: state.inTheathers, title: "In Theathers");
          comingSoon = PosterRoll(data: state.comingSoon, title: "Coming Soon");
          topRatedMovies = PosterRoll(data: state.topRatedMovies, title: "Top Rated Movies");
          genres = Genres(data: state.genres);
        }

        return ListView(
          children: <Widget>[
            trending,
            Divider(),
            popularMovies,
            Divider(),
            inTheathers,
            Divider(),
            comingSoon,
            Divider(),
            topRatedMovies,
            Divider(),
            genres,
          ],
        );
      },
    );

  }
}

