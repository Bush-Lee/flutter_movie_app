import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/home/homeBloc.dart';
import 'package:movie_app/blocs/home/homeEvent.dart';
import 'package:movie_app/blocs/home/homeState.dart';

import 'package:movie_app/ui/general/posterRoll.dart';
import 'package:movie_app/ui/general/slideshow.dart';
import 'package:movie_app/ui/general/genre.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      builder: (context) => HomeBloc()
        ..dispatch(HomeStarted()),
      child: HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<AppEvent, AppState>(
      bloc: homeBloc,
      builder: (BuildContext context, AppState state){
        Widget slideShow = Center(child: CircularProgressIndicator());
        Widget posterRoll = Center(child: CircularProgressIndicator());
        Widget genres = Center(child: CircularProgressIndicator());

        if (state is HomeLoaded) {
          slideShow = Slideshow(data: state.slideshow);
          posterRoll = PosterRoll(data: state.posterRoll, title: "Popular Movies");
          genres = Genres(data: state.genres);
        }

        return ListView(
          children: <Widget>[
            slideShow,
            Divider(),
            posterRoll,
            Divider(),
            genres,
          ],
        );
      },
    );

  }
}

