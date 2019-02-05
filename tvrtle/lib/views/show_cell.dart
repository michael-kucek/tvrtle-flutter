import 'package:flutter/material.dart';

final episodeSize = 120.0;

class ShowCell extends StatelessWidget {
  final show;

  ShowCell(this.show);

  @override
  Widget build(BuildContext context) {
    final eps = this.show["_embedded"]["episodes"].length;
    // return a new list.builder here for the episodes
    return new FractionallySizedBox(
      widthFactor: 0.9,
      child: new Column(children: <Widget>[
        new Poster(show: show),
        new ShowTitle(show: show),
        new SizedBox(
          height: episodeSize,
          child: new ListView.builder(
            itemCount: eps | 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              final en = this.show["_embedded"]["episodes"][i];
              // print(en);
              return new Episode(en);
            },
          ),
        ),
        new Text("$eps Episodes"),
        new Divider()
      ]),
    );
  }
}

class ShowTitle extends StatelessWidget {
  const ShowTitle({
    Key key,
    @required this.show,
  }) : super(key: key);

  final show;

  @override
  Widget build(BuildContext context) {
    return new Text(
      show["name"],
      style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    );
  }
}

class Poster extends StatelessWidget {
  const Poster({
    Key key,
    @required this.show,
  }) : super(key: key);

  final show;

  @override
  Widget build(BuildContext context) {
    return new Image.network(
      show["image"]["medium"],
      scale: 2.0,
    );
  }
}

class Episode extends StatelessWidget {
  final episode;

  Episode(this.episode);

  @override
  Widget build(BuildContext context) {
    // if (this.episode["image"] != null) {
    //   print(this.episode["image"]);
    // }
    try {
      return new SizedBox(
        width: episodeSize,
        child: Card(
            elevation: 4.0,
            margin: EdgeInsets.all(2.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(4.0),
                  child: Image.network(
                    this.episode["image"]["medium"],
                    fit: BoxFit.fitHeight,
                    width: episodeSize,
                  ),
                ),
                new Text(
                    'S${this.episode["season"]}E${this.episode["number"]}'),
                new Text(
                  this.episode["name"],
                  overflow: TextOverflow.ellipsis,
                )
              ],
            )),
      );
    } catch (e) {
      return new SizedBox(
          width: episodeSize,
          child: Card(child: Center(child: Text(this.episode["name"]))));
    }
  }
}
