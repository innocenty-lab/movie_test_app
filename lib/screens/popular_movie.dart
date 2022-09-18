import 'package:flutter/foundation.dart';
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
  String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movie"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiService().getPopularMovies(1),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return PopularMovieList(imageBaseUrl: imageBaseUrl, popularMovie: snapshot.data as dynamic);
          }
        },
      )
    );
  }
}

class PopularMovieList extends StatefulWidget {
  final PopularMovies popularMovie;
  final String imageBaseUrl;

  const PopularMovieList({
    Key? key,
    required this.imageBaseUrl, 
    required this.popularMovie,
  }) : super(key: key);

  @override
  State<PopularMovieList> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovieList> {
  ScrollController scrollController = ScrollController();
  List<Results> popularMovie = [];
  int currentPage = 1;

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        print('End Scroll');
        ApiService().getPopularMovies(currentPage + 1).then((val) {
          currentPage = val.page;
          setState(() {
            popularMovie.addAll(val.results);
          });
        });
      }
    }
    return true;
  }

  @override
  void initState() {
    popularMovie = widget.popularMovie.results;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: ListView.builder(
        itemCount: popularMovie.length,
        controller: scrollController,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (_) => MovieDetailPage(),
                  settings: RouteSettings(
                    arguments: popularMovie[index],
                  )
                )).then((_) {
                  setState(() {
                    // getResults();
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
                      child: Image.network("${widget.imageBaseUrl}${popularMovie[index].posterPath}"),
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
                                popularMovie[index].title, 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 22,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Text(DateFormat("dd-MM-yyyy").format(popularMovie[index].releaseDate)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Text("Popularity : ${popularMovie[index].popularity}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Text("Vote Average : ${popularMovie[index].voteAverage}"),
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
      ),
    );
  }
}