
class Movie {
  late int id;
  late String title;
  late double voteAvg;
  late String releaseDate;
  late String overview;
  late String posterPath;


  Movie(this.id, this.title, this.voteAvg, this.releaseDate, this.overview, this.posterPath);

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? "";
    voteAvg = json['vote_average'] * 1.0 ?? 0;
    releaseDate = json['release_date'] ?? "";
    overview = json['overview'] ?? "";
    posterPath = json['poster_path'] ?? "";
  }
}