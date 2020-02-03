import 'package:movie_app/data_layer/serializer/general/genre.dart';

import 'package:movie_app/ui/general/titleBar.dart';
import 'package:flutter/material.dart';

class DetailTitle extends StatelessWidget {
  final title;
  final backdropPath;
  final releaseDate;
  final runtime;

  DetailTitle({this.title, this.releaseDate, this.backdropPath, this.runtime});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF222222),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.network(
              backdropPath,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(releaseDate.split('-')[0],
                    style: TextStyle(fontSize: 15, color: Color(0xFF616161))),
                SizedBox(
                  width: 10,
                ),
                Text(" " + runtime.toString() + " min",
                    style: TextStyle(fontSize: 15, color: Color(0xFF616161))),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class DetailDescription extends StatelessWidget {
  final data;

  DetailDescription(this.data);

  @override
  Widget build(BuildContext context) {
    //TODO: data.genres at first is List<GenreModel> afterwards in alternates between GenreModel and a List<Dict>
    // The constant sqitching doesent always end up on a List<GenreModel> so sometimes the
    List<Widget> genres = [];
    if (data.genres is List<GenreModel>) {
      genres = data.genres
          .map<Widget>(
            (genreModel) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(genreModel.name)),
              ),
            ),
          )
          .toList();
    }
    return Container(
      color: Color(0xFF222222),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              data.posterPath,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 140,
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: genres,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 150,
                    alignment: Alignment.topLeft,
                    child: Text(
                      // Must be wrapped in a container with size  to know the when to softwrap
                      data.overview,
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
                Divider(), //TODO: Why doesnet this show ?
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailImages extends StatelessWidget {
  final images;

  DetailImages({this.images});

  @override
  Widget build(BuildContext context) {
    List<Widget> backdrops = [];
    for (int i = 0; i < images.backdrops.length; i++) {
      backdrops.add(Img(img: images.backdrops[i]));
    }
    return Container(
      width: MediaQuery.of(context).size.width,
//      height: 270,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3.0, color: Color(0xFF151515)),
        ),
        color: Color(0xFF222222),
      ),
      child: Column(
        children: <Widget>[
          TitleBar("Images"),
          Container(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: backdrops,
            ),
          ),
        ],
      ),
    );
  }
}

class Img extends StatelessWidget {
  final img;

  Img({this.img});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Image.network(
          img.path,
          height: 110,
        ),
      ),
    );
  }
}
