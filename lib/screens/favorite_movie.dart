import 'package:flutter/material.dart';

class FavoriteMoviePage extends StatefulWidget {
  FavoriteMoviePage({Key? key}) : super(key: key);

  @override
  State<FavoriteMoviePage> createState() => _FavoriteMoviePageState();
}

class _FavoriteMoviePageState extends State<FavoriteMoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: Center(
        child: Text("2"),
      ),
    );
  }
}