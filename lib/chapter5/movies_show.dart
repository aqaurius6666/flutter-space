import 'package:demo_flutter/chapter5/config.dart';
import 'package:demo_flutter/chapter5/http_helper.dart';
import 'package:demo_flutter/chapter5/movie.dart';
import 'package:demo_flutter/chapter5/movie_details.dart';
import 'package:flutter/material.dart';

class MoviesShow extends StatefulWidget {
  const MoviesShow({Key? key}) : super(key: key);

  @override
  State<MoviesShow> createState() => _MoviesShowState();
}

class _MoviesShowState extends State<MoviesShow> {

  late HttpHelper helper;
  late List<Movie> result = [];
  late int movieCount = 0;
  late int pageCount;

  Icon visibleIcon = Icon(Icons.search);
  Widget appBar = Text("Movies show");
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
      helper = HttpHelper();
      _scrollController.addListener(() {
        _scrollListener();
      });
      initialize();
      super.initState();
  }
  void _scrollListener() async {
    if (_scrollController.position.extentAfter <= 5) {

      var next = await helper.getNextUpComing();
      setState(() {
        pageCount = pageCount + 1;
        movieCount = movieCount + next.length;
        result.addAll(next);
      });
    }
  }
  Future<void> search(String text) async {
    result = await helper.searchMovies(text);
    _scrollController.animateTo(
      0,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,);
    setState(() {
      result = result;
      movieCount = result.length;
    });
  }
  @override
  Widget build(BuildContext context) {
    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: appBar,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  if (this.visibleIcon.icon == Icons.search) {
                    this.visibleIcon = Icon(Icons.cancel);
                    this.appBar = TextField(
                      textInputAction: TextInputAction.search,
                      style: TextStyle(
                        color: Config.PRIMARY_COLOR,
                        fontSize: 20.0,
                      ),
                      onSubmitted: (String text) {
                        search(text);
                      },
                    );
                  } else {
                    this.visibleIcon = Icon(Icons.search);
                    this.appBar = Text("Movies show");
                  }
                });
              },
              icon: visibleIcon),
        ],
      ),

      body: Container(
        child: ListView.builder(
          controller: _scrollController,
            itemBuilder: (BuildContext context, int position) {
              Movie curr = result[position];
              if (curr.posterPath != "") {
                image = NetworkImage(
                  Config.ICON_BASE + curr.posterPath
                );
              } else {
                image = NetworkImage(Config.DEFAULT_IMAGE);
              }
              return Card(
                color: Config.PRIMARY_COLOR,
                elevation: 2.0,
                child: ListTile(
                  title: Text(curr.title),
                  onTap: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (_) => MovieDetails(curr)
                    );
                    Navigator.push(context, route);
                  },
                  leading: CircleAvatar(
                    backgroundImage: image,
                  ),
                  subtitle: Text(
                    'Released: ' + curr.releaseDate + ' Vote: ' + curr.voteAvg.toString()
                  ),
                ),
              );
            },
          itemCount: movieCount,

        ),
      ),
    );
  }

  Future initialize() async {
    result = List<Movie>.empty();
    result = await helper.getUpcoming();
    pageCount = 2;
    setState(() {
      movieCount = result.length;
      result = result;
    });
  }
}
