import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_test_app/model/popular_movies_model.dart';
import 'package:themed/themed.dart';

class MovieDetailPage extends StatelessWidget {
  MovieDetailPage({Key? key}) : super(key: key);

  String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    final movieDetails = ModalRoute.of(context)!.settings.arguments as Result;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // title: Text("Movie Detail"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: FavoriteButton(
                isFavorite: false,
                valueChanged: (_isFavorite) {
                  print('Is Favorite : $_isFavorite');
                },
                iconSize: 38,
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Stack(
                alignment: Alignment.center,
                children: [

                  Container(
                    height: MediaQuery.of(context).size.width,
                    child: ChangeColors(
                      brightness: -0.6,
                      child: Image.network(
                        "$imageBaseUrl${movieDetails.backdropPath}",
                        fit: BoxFit.cover, 
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    height: MediaQuery.of(context).size.width * 0.8,
                    // color: Colors.amber,
                    child: Column(
                      children: [

                        Expanded(
                          child: Container(
                            // color: Colors.green,
                            child: Center(
                              child: Text(
                                "${movieDetails.originalTitle}", 
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 32, 
                                  fontWeight: FontWeight.bold, 
                                  color: Colors.white
                                ),
                              ),
                            )
                          )
                        ),

                        Container(
                          // color: Colors.blue,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Container(
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network("$imageBaseUrl${movieDetails.posterPath}", ),
                                ),
                              ),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Container(
                                    // color: Colors.black,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            "${movieDetails.title}", 
                                            style: TextStyle(
                                              color: Colors.white, 
                                              fontWeight: FontWeight.bold, 
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            "Popularity (${movieDetails.popularity})", 
                                            style: TextStyle(
                                              color: Colors.white70, 
                                              fontSize: 16
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            "Release Date (${DateFormat("dd-MM-yyyy").format(movieDetails.releaseDate)})",
                                            style: TextStyle(
                                              color: Colors.white70, 
                                              fontSize: 16
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          "Rate", 
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ), 

                    Center(
                      child: RatingBar.builder(
                        ignoreGestures: true,
                        itemSize: MediaQuery.of(context).size.width / 15,
                        initialRating: movieDetails.voteAverage,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 10,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          "Overview", 
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ), 

                    Text(
                      "${movieDetails.overview}", 
                      textAlign: TextAlign.justify,
                    ), 

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}