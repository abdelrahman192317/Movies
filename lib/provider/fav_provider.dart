import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/movies.dart';
import '../apis/api_call.dart';
import '../apis/urls.dart';

class FavPro extends ChangeNotifier {

  MovieDetails movieDetails = MovieDetails(
    id: 0,
    title: "",
    rate: 0,
    pPath: "",
    bPath: '',
    overview: '',
    popularity: 0,
    releaseDate: '',
    voteCount: 0,
  );
  List<Movie> searchedMovies = [];
  List<int> favIntMovies = [];
  List<Movie> favMovies = [];
  List<Future<Movie>> favMoviesTemp = [];
  List<Movie> topRatedMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> newPlayingMovies = [];
  List<Movie> upComingMovies = [];
  List<Movie> customMovies = [];

  int movieId = 0;
  updateId(int id) {
    movieId = id;
    notifyListeners();
  }


  getMovieDetails() async {
    movieDetails = await APICalls.getMovieDetails(movieId);
    notifyListeners();
  }

  getSearchedMovies(String text) async {
    searchedMovies = await APICalls.searchForMovies(text);
    notifyListeners();
  }

  getSavedFavData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String reJson = pref.getString('myList') ?? '';
    if(reJson != ''){
      favIntMovies = jsonDecode(reJson).cast<int>();
    }
    notifyListeners();
  }

  setFavData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String sJson = jsonEncode(favIntMovies);
    pref.setString('myList', sJson);
  }

  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('sign', 'false');
  }

  login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('sign', 'true');
  }

  void addToFav(int id) {
    favIntMovies.add(id);
    setFavData();
    getFavMovies();
    notifyListeners();
  }

  void deleteFromFav(int id) {
    favIntMovies.remove(id);
    setFavData();
    getFavMovies();
    notifyListeners();
  }

  getFavMovies() async {

    favMovies = [];

    favMoviesTemp = favIntMovies.map((id) => APICalls.getMovie(id)).toList();

    Movie movie;

    for (var ele in favMoviesTemp) {
      movie = await ele;
      favMovies.add(movie);
    }
    notifyListeners();
  }

  getTopRatedMovies() async {
    topRatedMovies = await APICalls.getTopRatedMovies();
    notifyListeners();
  }

  getPopularMovies() async {
    popularMovies = await APICalls.getCustomMovies(Urls.popularMovies);
    notifyListeners();
  }

  getNewPlayingMovies() async {
    newPlayingMovies = await APICalls.getCustomMovies(Urls.newPlayingMovies);
    notifyListeners();
  }

  getUpComingMovies() async {
    upComingMovies = await APICalls.getCustomMovies(Urls.upcomingMovies);
    notifyListeners();
  }

  String kind = '';

  setKind(String s){
    kind = s;
    clearCustomMovies();
    notifyListeners();
  }

  getCustomMovies() async {
    customMovies = await APICalls.getCustomMovies(kind);
    notifyListeners();
  }

  clearCustomMovies() {
    customMovies = [];
    notifyListeners();
  }

  int selected = 0;
  setSelectedBar(int sel){
    selected = sel;
    if(selected != 2) clearText();
    notifyListeners();
  }

  String search = '';
  setText(String text){
    search = text;
    getSearchedMovies(text);
    notifyListeners();
  }

  clearText(){
    search = '';
    searchedMovies = [];
  }

  isFav(int id){
    return favIntMovies.contains(id);
  }

}