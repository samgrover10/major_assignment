import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:major_assignment/model/movie.dart';
import 'package:http/http.dart' as http;

final String API_KEY = "a658bae4";

class MovieProvider extends ChangeNotifier {
  final String url = "http://www.omdbapi.com/?apikey=${API_KEY}&";

  List<Movie> movies = [];

  void getMoviesBySearch(String search) async {
    List<Movie> retrievedMovies = [];
    String searchUrl = url + "s=${search}&page=1";
    final result = await http.get(Uri.parse(searchUrl));
    Map<String, dynamic> json = jsonDecode(result.body);
    List<dynamic> searchResult = json['Search'];
    await Future.forEach(searchResult, (dynamic mv) async {
      String mvId = mv['imdbID'];
      String moreInfoUrl = url + "i=${mvId}";
      final res = await http.get(Uri.parse(moreInfoUrl));
      Map<String, dynamic> jsonResult = jsonDecode(res.body);
      String rating = jsonResult['imdbRating'];
      String genre = jsonResult['Genre'];
      print(mv['Poster']);
      retrievedMovies.add(Movie(
          genre: genre,
          imdbId: mvId,
          posterUrl: mv['Poster'],
          rating: rating,
          title: mv['Title']));
    });
    movies = retrievedMovies;
    notifyListeners();
  }
}
