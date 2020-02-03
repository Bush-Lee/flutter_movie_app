import 'package:flutter/material.dart';

class Selector extends StatelessWidget {
  var cardTitles;
  var title;
  Function({dynamic activeKey}) change;


  Selector({this.cardTitles, this.title, this.change});


  @override
  Widget build(BuildContext context) {
    Widget card(String text) => Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: InkWell(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Text(text, style: TextStyle(color: cardTitles[text] ? Colors.black  : Colors.white, ),),
          ),
          color: cardTitles[text] ? Colors.yellow  : Color(0XFF424242),
        ),
        onTap: () => change(activeKey: text),
      ),
    );

    var cards = cardTitles.keys.map<Widget>((title) => card(title)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 8, 4),
          child: Text(title, style: TextStyle(fontSize: 18),),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: cards,
            )),
      ],
    );
  }
}