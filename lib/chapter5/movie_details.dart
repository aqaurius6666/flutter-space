

import 'package:demo_flutter/chapter5/config.dart';
import 'package:demo_flutter/chapter5/movie.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;

  MovieDetails(this.movie);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String path;
    if (movie.posterPath != "") {
      path = Config.POSTER_BASE + movie.posterPath;
    } else {
      path = Config.DEFAULT_POSTER;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: height / 1.5,
                padding: EdgeInsets.all(16),
                child: Image.network(path),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(movie.overview),
              )
            ],
          ),
        ),
      ),
    );
  }
}
