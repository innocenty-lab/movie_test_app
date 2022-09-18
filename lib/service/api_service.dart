import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_test_app/model/popular_movies_model.dart';

class ApiService {
  // final _baseUrl = "https://api.themoviedb.org/3/movie/popular?api_key=";
  // final _apiKey = "1ff37996775b3582b9ac66820e8c6417";

  // Future<List<Result>> getPopularMovies() async {
  //   final response = await http.get(Uri.parse(_baseUrl+_apiKey));
  //   // print(response.body);
  //   if (response.statusCode == 200) {
  //     return PopularMovies.fromJson(json: json.decode(response.body)).results;

  //     // var jsonResonse =  PopularMovies.fromJson(json: json.decode(response.body)).results.toList();
  //   } else {
  //     throw Exception("Failed to get popular movie");
  //   }
  // }

  Future<List<Results>> getPopularMovies(int currentPage) async {
    var url = "https://api.themoviedb.org/3/movie/popular?api_key=1ff37996775b3582b9ac66820e8c6417&page=" + currentPage.toString();
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return PopularMovies.fromJson(json: json.decode(response.body)).results;
    } else {
      throw Exception("Failed to get popular movie");
    }
  }
}