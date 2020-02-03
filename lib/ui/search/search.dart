import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/home/homeBloc.dart';
import 'package:movie_app/blocs/home/homeEvent.dart';
import 'package:movie_app/blocs/home/homeState.dart';
import 'package:movie_app/data_layer/searchField.dart';
import 'package:movie_app/ui/search/widgets/singleSelect.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      builder: (context) => HomeBloc()..dispatch(SearchStarted()),
      child: SearchBar(),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<AppEvent, AppState>(
        bloc: bloc,
        builder: (BuildContext context, AppState state) {
          if (state is SearchLoaded) {
            var body = SearchBarBody(
              genres: state.genres,
            );
            return Scaffold(
              appBar: AppBar(
                leading: InkWell(
                  child: Icon(Icons.arrow_back),
                  onTap: () => Navigator.of(context).pop(),
                ),
                title: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search by title",
                  ),
                ),
              ),
              body: body,
              bottomSheet: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text("CLEAR"),
                    onPressed: () {
                      body.initParams();
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width / 4,
                    child: FlatButton(
                        color: Colors.yellow,
                        textColor: Colors.black,
                        child: Text("SEE RESULTS"),
                        onPressed: () => body.search.show()),
                  )
                ],
              ),
            );
          }
          return Material(child: Center(child: CircularProgressIndicator()));
        });
  }
}

class SearchBarBody extends StatefulWidget {
  final genres;

  SearchBarBody({this.genres});

  Map typeCards;
  Map voteCntCards;
  Map voteAvg;
  Map genreDict;
  SearchParams search;

  void initParams() {
    search = SearchParams();

    voteCntCards = Map.fromIterable(
        ["1.000+", "10.000+", "1.000.000+", "10.000.000+"],
        key: (v) => v, value: (v) => false);
    voteCntCards[voteCntCards.keys.first] = true;

    typeCards = {"Movie": search.isMovie, "TV Show": !search.isMovie};

    voteAvg = Map.fromIterable(["5+", "6+", "7+", "8+", "9+"],
        key: (v) => v, value: (v) => false);
    voteAvg[voteAvg.keys.first] = true;

    genreDict =
        Map.fromIterable(genres, key: (v) => v.name, value: (v) => false);
  }

  @override
  State<StatefulWidget> createState() {
    initParams();
    return SearchBarBodyState();
  }
}

class SearchBarBodyState extends State<SearchBarBody> {
  void selectType({dynamic activeKey}) {
    setState(() {
      widget.typeCards.keys
          .forEach((key) => widget.typeCards[key] = !widget.typeCards[key]);

      widget.search.isMovie = !widget.search.isMovie;
    });
  }

  void selectVoteCnt({dynamic activeKey}) {
    setState(() {
      widget.voteCntCards.keys.forEach((key) => activeKey == key
          ? widget.voteCntCards[activeKey] = true
          : widget.voteCntCards[key] = false);

      activeKey =
          activeKey.substring(0, activeKey.length - 1).split(".").join();
      widget.search.voteCountGte = int.parse(activeKey);
    });
  }

  void selectVoteAvg({dynamic activeKey}) {
    setState(() {
      widget.voteAvg.keys.forEach((key) => activeKey == key
          ? widget.voteAvg[activeKey] = true
          : widget.voteAvg[key] = false);

      widget.search.voteAverageGte = int.parse(activeKey[0]);
    });
  }

  void selectGenre({dynamic activeKey}) {
    setState(() {
      widget.genreDict[activeKey] = !widget.genreDict[activeKey];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Selector(
            cardTitles: widget.typeCards,
            title: "Title Type",
            change: selectType),
        Selector(
            cardTitles: widget.voteCntCards,
            title: "Number of votes",
            change: selectVoteCnt),
        Selector(
            cardTitles: widget.voteAvg,
            title: "Vote Average",
            change: selectVoteAvg),
        Selector(
            cardTitles: widget.genreDict, title: "Genre", change: selectGenre),
      ],
    );
  }
}
