import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/home/homeBloc.dart';
import 'package:movie_app/blocs/home/homeEvent.dart';
import 'package:movie_app/blocs/home/homeState.dart';
import 'package:movie_app/data_layer/serializer/movieSerializer/movie_list.dart';
import 'package:movie_app/data_layer/serializer/tvShowSerialzier/tv_list.dart';

class Listed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, String> loadIdentifier =
        ModalRoute.of(context).settings.arguments;

    return BlocProvider<HomeBloc>(
      builder: (context) =>
          HomeBloc()..dispatch(ListStarted(type: select_type(loadIdentifier))),
      child: ListContent(loadIdentifier.values.first),
    );
  }
}

class ListContent extends StatelessWidget {
  var title;

  ListContent(this.title);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<AppEvent, AppState>(
      bloc: bloc,
      builder: (BuildContext context, AppState state) {
        if (state is ListLoaded) {
          List<Widget> listEl = [
            Header(state.genres, title),
          ];
          for (int i = 0; i < state.data.length; i++) {
            if (state.data[i].posterPath != null) {
              listEl.add(
                  ContentCard(data: state.data[i], number: i, title: title));
            }
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Container(
                color: Color(0XFF1C1C1C),
                child: ListView(
                  children: listEl,
                )),
          );
        }
        return Material(child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

class ContentCard extends StatelessWidget {
  final data;
  final title;
  final number;

  ContentCard({this.data, this.title, this.number});

  @override
  Widget build(BuildContext context) {
    List<Widget> info = [];

    var titleStyle = TextStyle(fontSize: 20);
    var subDetailStyle = TextStyle(color: Color(0xFF737373), fontSize: 15,);
    var subStyle = TextStyle(fontSize: 15);

    info.add(Text(data.title, style: titleStyle, overflow: TextOverflow.ellipsis,));
    if (data is MovieModelShort) {
      if (title.contains("Soon")) {
        info.add(Text(data.releaseDate, style: subDetailStyle));
      } else if (title.contains("Rated")) {
        info.add(Row(
          children: <Widget>[
            Text(data.releaseDate, style: subDetailStyle),
          ],
        ));
        info.add(Text(
          "# " + (number + 1).toString(),
          style: subStyle,
        ));
      } else {
        info.add(Row(
          children: <Widget>[
            Text(data.releaseDate),
          ],
        ));
      }
      info.add(Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            data.voteAverage.toString(),
            style: subStyle,
          )
        ],
      ));
    }
    if (data is TvModelShort) {
      info.add(Row(
        children: <Widget>[
          Text(data.firstAirDate, style: subDetailStyle),
        ],
      ));
      info.add(Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            data.voteAverage.toString(),
            style: subStyle,
          )
        ],
      ));
    }

    var bloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, AppState state) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/Detail", arguments: data);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                      color: Color(0xFF383838),
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: Color(0xFF383838),
                      width: 1,
                    ))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    data.posterPath,
                    height: 130,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width - 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: info,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class Header extends StatelessWidget {
  final genres;
  final title;

  Header(this.genres, this.title);

  @override
  Widget build(BuildContext context) {
    var genre_cards = genres
        .map((x) => x.name)
        .map<Widget>((x) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(x)),
              ),
              color: Color(0XFF1C1C1C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                    color: Color(0XFF3E3E3E),
                  )),
            ))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 25),
            ),
          ),
//          Divider(color: Color(0xFF383838),),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 16,
            child: ListView(
                scrollDirection: Axis.horizontal, children: genre_cards),
          )
        ],
      ),
    );
  }
}

select_type(Map<String, String> loadIdentifier) {
  switch (loadIdentifier["state"]) {
    case "Home Page Loaded":
      {
        if (loadIdentifier["title"].contains("Popular")) {
          return "MP";
        }
        if (loadIdentifier["title"].contains("Genres")) {}
        return "PG";
      }
      break;
    case "Movie Page Loaded":
      {
        if (loadIdentifier["title"].contains("Movies")) {
          return "MP";
        }
        if (loadIdentifier["title"].contains("Theathers")) {
          return "MT";
        }
        if (loadIdentifier["title"].contains("Soon")) {
          return "MS";
        }
        if (loadIdentifier["title"].contains("Rated")) {
          return "MR";
        }
        if (loadIdentifier["title"].contains("Genres")) {
          return "MG";
        }
      }
      ;
      break;
    case "Tv Page Loaded":
      {
        if (loadIdentifier["title"].contains("Popular")) {
          return "TVP";
        }
        if (loadIdentifier["title"].contains("Airing")) {
          return "TVA";
        }
        if (loadIdentifier["title"].contains("Genres")) {
          return "TVG";
        }
      }
      break;
  }
}
