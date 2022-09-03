import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_test_app/screens/movie_detail.dart';
import 'package:movie_test_app/components/toast.dart';
import '../model/popular_movies_model.dart';
import '../service/api_service.dart';

class PopularMoviePage extends StatefulWidget {
  const PopularMoviePage({Key? key}) : super(key: key);

  @override
  State<PopularMoviePage> createState() => _PopularMoviePageState();
}

class _PopularMoviePageState extends State<PopularMoviePage> {
  List<Result> resultListMovies = [];
  ApiService apiService = ApiService();
  String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  Toast toast = Toast();

  getPopularMovies() async {
    resultListMovies = await apiService.getPopularMovies();
    toast.showToast(context, "page has been refreshed");
    setState(() {});
  }

  @override
  void initState() {
    getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movie"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: resultListMovies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (_) => MovieDetailPage(),
                  settings: RouteSettings(
                    arguments: resultListMovies[index],
                  )
                )).then((_) {
                  setState(() {
                    getPopularMovies();
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
                      child: Image.network("$imageBaseUrl${resultListMovies[index].posterPath}"),
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
                                "${resultListMovies[index].title}", 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 22,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Text(DateFormat("dd-MM-yyyy").format(resultListMovies[index].releaseDate)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Text("Popularity : ${resultListMovies[index].popularity}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Text("Vote Average : ${resultListMovies[index].voteAverage}"),
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
      )
    );
  }
}