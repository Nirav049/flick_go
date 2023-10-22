import 'package:flick_go/navigationBar.dart';
import 'package:flick_go/pages/movie_details.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  int _currentIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Color.fromRGBO(33, 150, 243, 1),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _currentIndex,
        onItemSelected: _onItemTapped,
      ),
      body: favoritesList.isEmpty
          ? Center(
              child: Text('No favorite movies added.'),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                childAspectRatio:
                    0.7, // Aspect ratio of each grid item (adjust as needed)
              ),
              itemCount: favoritesList.length,
              itemBuilder: (context, index) {
                final movie = favoritesList[index];

                return Card(
                  color: Color.fromRGBO(240, 249, 255, 1),
                  elevation: 4,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Movie Poster
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            height: 235,
                            width: 190,
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w185/${movie['poster_path'] ?? ''}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          // Movie Title
                          Text(
                            movie['title'] ?? 'No Title',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                              // Remove Button
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Remove the favorite movie from the list
                                  setState(() {
                                    favoritesList.removeAt(index);
                                  });
                                },
                              ),
                        ]),
                      ]),
                );
              },
            ),
    );
  }
}
