import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/home/homeBloc.dart';
import 'package:movie_app/blocs/home/homeEvent.dart';
import 'package:movie_app/blocs/home/homeState.dart';
import 'package:movie_app/ui/detail/widgets.dart';
import 'package:movie_app/ui/general/posterRoll.dart';

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var detail = ModalRoute.of(context).settings.arguments;
    return BlocProvider<HomeBloc>(
        builder: (context) => HomeBloc()..dispatch(DetailRequest(data: detail)),
        child: MovieDetail());
  }
}

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, AppState state) {
        if (state is DetailLoading) {
          return Material(child: Center(child: CircularProgressIndicator()));
        } else if (state is MovieDetailLoaded) {
          return Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.movie),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Icon(Icons.search),
                )
              ],
            ),
            body: WillPopScope(
              child: ListView(
                children: <Widget>[
                  DetailTitle(
                    title: state.movieData.title,
                    releaseDate: state.movieData.releaseDate,
                    backdropPath: state.movieData.backdropPath,
                    runtime: state.movieData.runtime,
                  ),
                  InkWell(
                    child: DetailDescription(state.movieData),
                    onTap: () {
                      print("New screen with more text");
                    },
                  ),
                  Divider(),
                  PosterRoll(title: "Top Billed Cast", data: state.creditsData),
                  Divider(),
                  DetailImages(images: state.images,),
                ],
              ),
              onWillPop: () {
                Navigator.of(context).pushNamed("/Base");
              },
            ),
          );
        } else if (state is TvDetailLoaded) {
          return Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.movie),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Icon(Icons.search),
                )
              ],
            ),
            body: WillPopScope(
              child: ListView(
                children: <Widget>[
                  DetailTitle(
                    title: state.tvData.title,
                    releaseDate: state.tvData.firstAirDate,
                    backdropPath: state.tvData.backdropPath,
                    runtime: state.tvData.episodeRunTime,
                  ),
                  InkWell(
                    child: DetailDescription(state.tvData),
                    onTap: () {
                      print("Push a screen with the full description");
                    },
                  ),
                  Divider(),
                  PosterRoll(title: "Top Billed Cast", data: state.creditsData),
                  Divider(),
                  DetailImages(images: state.images,),
                ],
              ),
              onWillPop: () {
                Navigator.of(context).pushNamed("/Base");
              },
            ),
          );
        }
        return Material(child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}



