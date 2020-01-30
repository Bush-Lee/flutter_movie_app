import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/home/homeBloc.dart';
import 'package:movie_app/blocs/home/homeEvent.dart';
import 'package:movie_app/blocs/home/homeState.dart';
import 'package:movie_app/data_layer/serializer/tvShowSerialzier/tv_list.dart';

class Slideshow extends StatelessWidget {
  final data;

  Slideshow({this.data});
//  Slideshow({this.data, this.bloc});

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      List<BannerCard> cards = [];
      for (int i = 0; i < data.length; i++) {
        if (data[i].backdropPath != null && data[i].posterPath != null) { // Might be that if video is true the api returns null
          cards.add(BannerCard(data: data[i]));
        }
      }
      return Container(
        height: 302,
        child: PageView(children: cards),
      );
    }
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.white,
    ));
  }
}

class BannerCard extends StatelessWidget {
  final data;

  BannerCard({this.data});

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<AppEvent, AppState>(
      bloc: homeBloc,
      builder: (BuildContext context, AppState state) {
        if (data is TvModelShort) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 3.0, color: Color(0xFF151515)),
              ),
              color: Color(0xFF222222),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    InkWell(
                      child: Image.network(
                        data.backdropPath,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Container(
                            color: Colors.red,
//                            width: 500,
//                            height: 300,
//                            height: MediaQuery.of(context).size.height * 500 / MediaQuery.of(context).size.width ,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("/Detail", arguments: data);
                      },
                    ),
                    // Text
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF222222),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(135, 5, 0, 0),
                        child: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  data.title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  data.firstAirDate,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF616161)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    left: MediaQuery.of(context).size.width / 16,
                    top: 300 / 2.5,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("/Detail", arguments: data);
                      },
                      child: Image.network(
                        data.posterPath,
                        height: 150,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Container(
                            height: 150,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                      ),
                    )),
              ],
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 3.0, color: Color(0xFF151515)),
            ),
            color: Color(0xFF222222),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  InkWell(
                    child: Image.network(
                      data.backdropPath,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Container(
                          color: Colors.red,
//                            height: MediaQuery.of(context).size.height * 500 / MediaQuery.of(context).size.width , // TODO: Calculate % of img width from screen width (img_width = 500)
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed("/Video", arguments: data);
                    },
                  ),
                  // Text
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFF222222),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(135, 5, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                data.title,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                data.releaseDate,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF616161)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width / 16,
                  top: 300 / 2.5,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed("/Detail", arguments: data);
                    },
                    child: Image.network(
                      data.posterPath,
                      height: 150,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Container(
                          height: 150,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
