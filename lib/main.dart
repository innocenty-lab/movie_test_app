import 'package:flutter/material.dart';
import 'package:movie_test_app/screens/favorite_movie.dart';
import 'package:movie_test_app/screens/popular_movie.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainBottomAppBar(),
    );
  }
}

class MainBottomAppBar extends StatefulWidget {
  const MainBottomAppBar({Key? key}) : super(key: key);

  @override
  State<MainBottomAppBar> createState() => _MainBottomAppBarState();
}

class _MainBottomAppBarState extends State<MainBottomAppBar> {
  var _currentIndex = 0;

  final tabs = [
    PopularMoviePage(), 
    FavoriteMoviePage(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie), 
            label: "Popular", 
            backgroundColor: Colors.blue
          ), 
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite), 
            label: "Favourite",
            backgroundColor: Colors.blue
          ), 
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}