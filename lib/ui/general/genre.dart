import 'package:flutter/material.dart';
import 'package:movie_app/ui/general/titleBar.dart';


class Genres extends StatelessWidget {
  final data;

  Genres({this.data});

  @override
  Widget build(BuildContext context) {
    var pairs = [];
    for (int i = 0; i < data.length - 2; i += 2) {
      pairs.add([data[i], data[i + 1]]);
    }
    var genreImgCards = pairs.map((value) => GenreImgCard(value[0], value[1])).toList();


    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF222222),
        border: Border(
          bottom: BorderSide(width: 5.0, color: Color(0xFF151515)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 25, 10, 5),
        child: Column(
          children: <Widget>[
            TitleBar("Popular Genres"),
            Container(
              height: 190,
              child: Container(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(10),
                  children: genreImgCards,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GenreImgCard extends StatelessWidget {
  String genreName1;
  String genreName2;

  GenreImgCard(this.genreName1, this.genreName2);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Column(children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            "assets/images/movie_genre/" + genreName1,
            height: 80,
          ),
        ),
        Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            "assets/images/movie_genre/" + genreName2,
            height: 80,
          ),
        )
      ]),
    );
  }
}
