import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/home/homeBloc.dart';
import 'package:movie_app/blocs/home/homeEvent.dart';
import 'package:movie_app/blocs/home/homeState.dart';
import 'package:movie_app/ui/general/detail/detail.dart';

class VideoPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context).settings.arguments;
    return BlocProvider<HomeBloc>(
      builder: (context) => HomeBloc()..dispatch(DetailRequest(data: data)),
      child: Video(),
    );
  }
}

class Video extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, AppState state) {
          if (state is DetailLoading) {
            return Material(child: Center(child: CircularProgressIndicator()));
          } else if (state is MovieDetailLoaded) {
            if (state.movieData.videos.isEmpty) {
              return MovieDetail();
            }
            return Container(color: Colors.deepOrange,);
          }
          return Material(child: Center(child: CircularProgressIndicator()));
        });
  }
}
