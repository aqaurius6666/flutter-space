import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'movie.dart';

class HttpHelper {
  final String urlKey = "api_key=2e2256aa5c442e69dfa23acbc421e675";
  final String urlBase = "https://api.themoviedb.org/3";
  final String urlUpcoming = "/movie/upcoming?";
  final String urlSearch = "/search/movie?";
  final String query = "&query=";
  final String urlLanguage = "&language=en-US";


  Future<List<Movie>> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;
    http.Response result = await http.get(Uri.parse(upcoming));

    if (result.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(result.body);
        final moviesMap = jsonResponse['results'];
        List<Movie> movies = List<Movie>.from(moviesMap.map((i) => Movie.fromJson(i)).toList()) ;
        return movies;
    }

    return [];
  }

  Future<List<Movie>> searchMovies(String q) async {
    final String upcoming = urlBase + urlSearch + urlKey + query + q;
    http.Response result = await http.get(Uri.parse(upcoming));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      print( moviesMap );
      List<Movie> movies = List<Movie>.from(
          moviesMap.map((i) => Movie.fromJson(i)).toList()) ;
      return movies;
    }

    return [];
  }
}

