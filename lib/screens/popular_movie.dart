import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_test_app/screens/movie_detail.dart';
import '../model/popular_movies_model.dart';
import '../service/api_service.dart';

class PopularMoviePage extends StatefulWidget {
  const PopularMoviePage({Key? key}) : super(key: key);

  @override
  State<PopularMoviePage> createState() => _PopularMoviePageState();
}

class _PopularMoviePageState extends State<PopularMoviePage> {
  List<Results> results = [];
  ApiService apiService = ApiService();
  String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  Future<List<Results>> getResults() async {
    results = await apiService.getPopularMovies(1);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movie"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Results>>(
        future: getResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (_) => MovieDetailPage(),
                        settings: RouteSettings(
                          arguments: snapshot.data?[index],
                        )
                      )).then((_) {
                        setState(() {
                          getResults();
                        });
                      });
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: 150,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network("$imageBaseUrl${snapshot.data?[index].posterPath ?? snapshot.data?[0].posterPath}"),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              // color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      snapshot.data![index].title, 
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold, 
                                        fontSize: 22,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                                    child: Text(DateFormat("dd-MM-yyyy").format(snapshot.data![index].releaseDate)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                                    child: Text("Popularity : ${snapshot.data![index].popularity}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                                    child: Text("Vote Average : ${snapshot.data![index].voteAverage}"),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          }
        }
      ),
    );
  }
}