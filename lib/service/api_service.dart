import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_test_app/model/popular_movies_model.dart';

class ApiService {
  final _baseUrl = "https://api.themoviedb.org/3/movie/popular?api_key=";
  final _apiKey = "1ff37996775b3582b9ac66820e8c6417";

  Future<PopularMovies> getPopularMovies(int currentPage) async {
    var url = "$_baseUrl$_apiKey&page=$currentPage";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return PopularMovies.fromJson(json: json.decode(response.body));
    } else {
      throw Exception("Failed to get popular movie");
    }
  }
}