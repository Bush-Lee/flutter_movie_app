import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/home/homeBloc.dart';
import 'package:movie_app/blocs/home/homeEvent.dart';
import 'package:movie_app/blocs/home/homeState.dart';

class TitleBar extends StatelessWidget {
  final String _title;

  TitleBar(this._title, );

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<AppEvent, AppState>(
      bloc: homeBloc,
      builder: (BuildContext context, AppState state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Row(
            children: <Widget>[
              Text(
                _title,
                style: TextStyle(fontSize: 22),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 22, 0, 0),
                child: InkWell(
                  child: Text(
                    "SEE ALL",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    var loadIdentifier = {
                      "title": _title,
                      "state": state.toString()
                    };
                    Navigator.of(context).pushNamed("/Listed", arguments: loadIdentifier);
                    },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
