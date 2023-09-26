import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flick_go/navigationBar.dart';
import 'package:flutter/material.dart';

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
      body: Container(
          height: _deviceHeight,
          width: _deviceWidth,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Expanded(child: _foregroundWidgets()),
              Expanded(child: _buildSearchResult())
            ],
          ),
        ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _currentIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }

  Widget _foregroundWidgets() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _deviceHeight! * 0.01, 0, 0),
      width: _deviceWidth! * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topBarWidget(),

        ],
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchFieldWidget(),
        ],
      ),
    );
  }

  Widget _searchFieldWidget() {
    return Container(
      width: _deviceWidth! * 0.8,
      //height: _deviceHeight! * 0.1, // Adjust the height
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
          border: myinputborder(),
          focusedBorder: myinputborder(),
          enabledBorder: myinputborder(),
        ),
      ),
    );
  }

  Widget _buildSearchResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: _deviceHeight! * 0.65,
          width: _deviceWidth! * 0.9,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2/3, // Number of columns in the grid
              crossAxisSpacing: 5.0, // Spacing between columns
              mainAxisSpacing: 5.0, // Spacing between rows
            ),
            itemCount: _searchedMovies.length,
            itemBuilder: (BuildContext context, int index) {
              var movie = _searchedMovies[index];
              return InkWell(
                onTap: () {
                  // Handle movie selection (e.g., navigate to movie details)
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  child: Image.network(
                    movie.posterUrl,
                    // Adjust the height as needed

                  ),
                ),
              );
            },
          ),
        ),
      ],
    );

  }
  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(9)),
      borderSide: BorderSide(
        color: Color.fromRGBO(33, 150, 243, 1),
        width: 3,
      ),
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

      final searchedMovies = results.map((result) => Movie.fromJson(result)).toList();

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

  Movie({required this.title, required this.posterUrl});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? 'Unknown',
      posterUrl: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w200${json['poster_path']}'
          : 'https://example.com/default_poster.jpg', // Replace with your default poster URL
    );
  }
}