import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/home/homeBloc.dart';
import 'package:movie_app/blocs/home/homeEvent.dart';
import 'package:movie_app/blocs/home/homeState.dart';
import 'package:movie_app/data_layer/serializer/credits.dart';
import 'package:movie_app/ui/general/titleBar.dart';

class PosterRoll extends StatelessWidget {
  final data;
  final title;

  PosterRoll({this.data, this.title});

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      List<CardRoll> cards = [];
      if (data is Credits) {
        for (int i =0; i<data.cast.length; i++) {
          if (data.cast[i].profilePath != null) {
            cards.add(CardRoll(data.cast[i]));
          }
        }
      } else {
        for (int i = 0; i < data.length; i++) {
          if (data[i].posterPath != null) {
            cards.add(CardRoll(data[i]));
          }
        }
      }

      return Container(
        height: 370,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 3.0, color: Color(0xFF151515)),
          ),
          color: Color(0xFF222222),
        ),
        child: Column(
          children: <Widget>[
            TitleBar(title),
            Container(
              height: 270,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: cards,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(color: Colors.green, width: 100, height: 100,);
    }
  }
}

class CardRoll extends StatelessWidget {
  final data;

  CardRoll(this.data);

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return BlocBuilder<AppEvent, AppState> (
      bloc: homeBloc,
      builder: (BuildContext context, AppState state){
        if (state is HomeLoaded || state is MoviesLoaded) {
          return InkWell(
            onTap: () {
              homeBloc.dispatch(DetailRequest(data: data));
              Navigator.of(context).pushNamed("/Detail", arguments: data);
            },
            child: Container(
              width: 130,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                      child: Image.network(data.posterPath, height: 180),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 10, 0, 10),
                      child: Text(data.title, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                      child: Text(data.releaseDate),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is TvLoaded) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("/Detail", arguments: data);
            },
            child: Container(
              width: 130,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                      child: Image.network(data.posterPath, height: 180),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 10, 0, 10),
                      child: Text(data.title, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          );
        }
        else if (state is MovieDetailLoaded) {
          return InkWell(
            onTap: () {
              print("Push the actor");
            },
            child: Container(
              width: 130,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                      child: Image.network(data.profilePath, height: 180),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 10, 0, 0),
                      child: Text(data.name, style: TextStyle(fontSize: 16,),maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                      child: Text(data.character, style: TextStyle(fontSize: 14, color: Color(0xFF606060)),maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is TvDetailLoaded) {
          return InkWell(
            onTap: () {
              print("Push a actor");
            },
            child: Container(
              width: 130,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                      child: Image.network(data.profilePath, height: 180),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 10, 0, 0),
                      child: Text(data.name, style: TextStyle(fontSize: 16,),maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                      child: Text(data.character, style: TextStyle(fontSize: 14, color: Color(0xFF606060)),maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container(color: Colors.green, height: 100, width: 100, child: Text("biscuits"),);
      },
    );
  }
}
