import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './views/show_cell.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RealWorldState();
  }
}

class RealWorldState extends State<MyApp> {
  var _isLoading = true;

  var shows = [];

  _fetchData() async {
    print("Attempting to fetch data from network");
    final ids = [123, 180, 318, 321, 82, 375, 551];
    for (var id in ids) {
      print("on $id");
      final url = "http://api.tvmaze.com/shows/$id?embed=episodes";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // print(response.body);

        final showData = json.decode(response.body);

        // showsJson.forEach((video) {
        //   print(video["name"]);
        // });

        setState(() {
          _isLoading = false;
          this.shows.add(showData);
        });
      } else {
        print("error");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // return new MaterialApp();
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("tvrtle"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                print("Reloading...");
                setState(() {
                  _isLoading = true;
                });
                _fetchData();
              },
            )
          ],
        ),
        body: new Center(
          child: _isLoading
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount: this.shows != null ? this.shows.length : 0,
                  itemBuilder: (context, i) {
                    final show = this.shows[i];
                    return new FlatButton(
                      padding: new EdgeInsets.all(0.0),
                      child: new ShowCell(show),
                      onPressed: () {
                        print("show cell tapped: $i");
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new DetailPage()));
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Detail page"),
      ),
      body: new Center(
        child: new Text("Detail detail detail"),
      ),
    );
  }
}
