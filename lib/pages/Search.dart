import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_go/pages/movie_details.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flick_go/navigationBar.dart';
// Make sure to import MovieDetailScreen from the correct file.

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentIndex = 1;
  double? _deviceHeight;
  double? _deviceWidth;

  TextEditingController _searchTextFieldController = TextEditingController();
  List<Movie> _searchedMovies = [];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
        backgroundColor: Color.fromRGBO(33, 150, 243, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: _deviceHeight,
          width: _deviceWidth,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  _topBarWidget(),
                  Expanded(child: _buildSearchResult()),
                ],
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _currentIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight! * 0.06,
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 249, 255, 1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 8.0),
          // Adjust the top padding as needed
          child: _searchFieldWidget(),
        ),
      ),
    );
  }

  Widget _searchFieldWidget() {
    return Container(
      width: _deviceWidth! * 0.8,
      child: TextField(
        controller: _searchTextFieldController,
        style: TextStyle(color: Color.fromRGBO(33, 150, 243, 1)),
        decoration: InputDecoration(
          labelText: "Search..",
          labelStyle: TextStyle(
            color: Color.fromRGBO(33, 150, 243, 1),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            color: Color.fromRGBO(33, 150, 243, 1),
            onPressed: () {
              _performSearch(_searchTextFieldController.text);
            },
          ),
          border: myInputBorder(),
          focusedBorder: myInputBorder(),
          enabledBorder: myInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder myInputBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(9)),
      borderSide: BorderSide(
        color: Color.fromRGBO(33, 150, 243, 1),
        width: 3,
      ),
    );
  }

  Widget _buildSearchResult() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: _searchedMovies.length,
      itemBuilder: (BuildContext context, int index) {
        var movie = _searchedMovies[index];
        return InkWell(
          onTap: () {
            // Handle movie selection
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MovieDetailScreen(movie: {
                  'title': movie.title,
                  'poster_path': movie.posterUrl,
                  'overview':movie.overview,
                  'voteaverage': movie.voteAverage,
                }),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            padding: EdgeInsets.symmetric(
                vertical: _deviceHeight! * 0.01, horizontal: 0),
            width: 230,
            height: 160,
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: movie.posterUrl,
                  height: _deviceHeight! * 0.25,
                  width: _deviceWidth! * 0.85,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 1),
                Text(
                  movie.title,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _performSearch(String query) async {
    final apiKey = '92a3819765c0405b6fd4199a163d60ad';
    final url = Uri.parse(
      'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      final searchedMovies =
          results.map((result) => Movie.fromJson(result)).toList();

      setState(() {
        _searchedMovies = searchedMovies;
      });
    } else {
      // Handle API error
      print('API Error: ${response.statusCode}');
    }
  }
}

class Movie {
  final String title;
  final String posterUrl;
  final String overview;
  final String releaseDate;
  final double voteAverage; // Change this to double
  final List<String> topCast;

  Movie({
    required this.title,
    required this.posterUrl,
    this.overview = '',
    this.releaseDate = '',
    this.voteAverage = 0.0, // Default to 0.0 as a double
    this.topCast = const [],
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? 'Unknown',
      posterUrl: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w200${json['poster_path']}'
          : 'https://example.com/default_poster.jpg',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: json['vote_average'] != null
          ? (json['vote_average'] as num).toDouble() // Parse as double
          : 0.0, // Default to 0.0 if not present or invalid
      topCast: [], // You can fetch and parse top cast here
    );
  }
}
