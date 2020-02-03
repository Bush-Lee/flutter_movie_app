import 'package:flutter/material.dart';
import 'package:movie_app/ui/detail/detail.dart';
import 'package:movie_app/ui/listView/listView.dart';
import 'package:movie_app/ui/search/search.dart';
import 'package:movie_app/ui/video/video.dart';

import 'package:movie_app/ui/home.dart';
import 'package:movie_app/ui/movies.dart';
import 'package:movie_app/ui/tv.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var theme = ThemeData(
    brightness: Brightness.dark,
//    canvasColor: Color(0XFF1C1C1C),
//          canvasColor: Colors.white,
    primaryColor: Color(0xFF383838),

    backgroundColor: Color(0XFF1C1C1C),
    appBarTheme: AppBarTheme(
      color: Color(0xFF383838),
    ),
    bottomAppBarTheme:
        BottomAppBarTheme(color: Color(0XFF2E2E2E), elevation: 10),
    cardColor: Color(0XFF2B2B2B),
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(fontSize: 16, color: Colors.white),
      unselectedLabelStyle: TextStyle(fontSize: 16, color: Colors.white),
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
        color: Color(0XFFF5C515),
        width: 2,
      )),
//          indicator: Decoration(),
    ),
    accentColor: Color(0xFFA87B01),
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      routes: {
        "/Base": (BuildContext context) => Base(),
        "/Detail": (BuildContext context) => Detail(),
        "/Listed": (BuildContext context) => Listed(),
        "/Video": (BuildContext context) => VideoPlayer(),
        "/Search": (BuildContext context) => Search(),
      },
      home: Base(),
    );
  }
}

class Base extends StatefulWidget {
  @override
  State<Base> createState() => BaseState();
}

class BaseState extends State<Base> {
  @override
  Widget build(BuildContext context) {
    List<String> _tabTitles = <String>["HOME", "MOVIES", 'TV'];
    int _index;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.movie),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: InkWell(
                  onTap: () => Navigator.of(context).pushNamed("/Search"),
                  child: Icon(Icons.search)),
            )
          ],
          bottom: TabBar(
            tabs: _tabTitles
                .map((value) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 15),
                      ),
                    ))
                .toList(),
            onTap: (index) {
              _index = index;
            }, // use setState
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Home(),
            Movies(),
            Tv(),
          ],
        ),
      ),
    );
  }
}
