import 'package:http/http.dart';
import 'dart:convert';

import '../models/movies.dart';
import 'urls.dart';

class APICalls {

  static Future<Movie> getMovie(int id) async {

    Movie movie = Movie(
      id: 0,
      title: "",
      rate: 0,
      releaseDate: '',
      path: ''
    );

    //https://api.themoviedb.org/3/movie/550?api_key=eb03df251074313f6e24c705f23a1cdc

    Uri path = Uri.https(Urls.baseUrl,'3/movie/$id', {'api_key': Urls.apiKey});

    Response response = await get(path);
    var data = jsonDecode(response.body);
    movie = Movie.fromMap(data);

    return movie;
  }

  static Future<MovieDetails> getMovieDetails(int id) async {

    //https://api.themoviedb.org/3/movie/550?api_key=eb03df251074313f6e24c705f23a1cdc

    MovieDetails movieDetails = MovieDetails(
      id: 0,
      title: "",
      rate: 0,
      pPath: "",
      bPath: "",
      overview: '',
      popularity: 0,
      releaseDate: '',
      voteCount: 0,
    );

    Uri path = Uri.https(Urls.baseUrl, '3/movie/$id', {'api_key': Urls.apiKey});
    Response response = await get(path);
    var data = jsonDecode(response.body);
    movieDetails = MovieDetails.fromMap(data);

    return movieDetails;
  }

  static Future<List<Movie>> getTopRatedMovies() async {

    List<Movie> movies = [];

    Uri url = Uri.https(Urls.baseUrl, Urls.topRated, {'api_key': Urls.apiKey});
    Response response = await get(url);
    var data = jsonDecode(response.body);
    data['results'].take(10).forEach(
          (elem) => movies.add(Movie.fromMap(elem),),
    );

    return movies;
  }

  static Future<List<Movie>> getCustomMovies(String customMovies) async {

    //https://api.themoviedb.org/3/movie/popular?api_key=eb03df251074313f6e24c705f23a1cdc

    List<Movie> movies = [];

    Uri uri = Uri.https(Urls.baseUrl, customMovies, {'api_key': Urls.apiKey});
    Response response = await get(uri);

    var re = jsonDecode(response.body);
    var data = re['results'] as List;
    movies = data.map((elem) => Movie.fromMap(elem)).toList();

    return movies;
  }

  static Future<List<Movie>> searchForMovies(String value) async {

    //https://api.themoviedb.org/3/search/movie?api_key={api_key}&query={MovieName}

    List<Movie> list = [];

    Uri url = Uri.https(Urls.baseUrl, Urls.search, {'api_key' : Urls.apiKey, 'query': value});

    Response response = await get(url);
    var re = jsonDecode(response.body);
    var data = re["results"] as List;
    list = data.map((elem) => Movie.fromMap(elem)).toList();

    return list;
  }

}