import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/home/homeBloc.dart';
import 'package:movie_app/blocs/home/homeEvent.dart';
import 'package:movie_app/blocs/home/homeState.dart';

import 'package:movie_app/ui/general/posterRoll.dart';
import 'package:movie_app/ui/general/slideshow.dart';
import 'package:movie_app/ui/general/genre.dart';

class Tv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      builder: (context) => HomeBloc()
        ..dispatch(TvStarted()),
      child: TvWidget(),
    );
  }
}

class TvWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<AppEvent, AppState>(
      bloc: homeBloc,
      builder: (BuildContext context, AppState state){
        Widget trending = Center(child: CircularProgressIndicator());
        Widget posterRoll = Center(child: CircularProgressIndicator());
        Widget genres = Center(child: CircularProgressIndicator());
        Widget inTheathers = Center(child: CircularProgressIndicator());

        if (state is TvLoaded) {
          trending = Slideshow(data: state.trending,);
          posterRoll = PosterRoll(data: state.popularTv, title: "Most Popular Tv");
          inTheathers = PosterRoll(data: state.airingToday, title: "Airing Today");
          genres = Genres(data: state.genres);

        }

        return ListView(
          children: <Widget>[
            trending,
            Divider(),
            posterRoll,
            Divider(),
            inTheathers,
            Divider(),
            genres,
          ],
        );
      },
    );

  }
}

