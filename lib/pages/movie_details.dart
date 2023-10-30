import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? movie;

  MovieDetailScreen({required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> topCast = [];

    // Check if the movie data is available and if the 'credits' field exists.
    if (widget.movie != null && widget.movie!['credits'] != null) {
      // Retrieve the 'cast' list from the 'credits' field.
      final List<dynamic>? castList = widget.movie!['credits']['cast'];

      // Check if the 'castList' is not null and not empty.
      if (castList != null && castList.isNotEmpty) {
        // Assign 'castList' to 'topCast' if it's valid.
        topCast = List<Map<String, dynamic>>.from(castList);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie?['title'] ?? 'Movie Details'),
        backgroundColor: Color.fromRGBO(33, 150, 243, 1),
        actions: [
          if (widget.movie != null)
            IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,color: Colors.black,),
              onPressed: () {
                // Toggle the favorite status
                setState(() {
                  isFavorite = !isFavorite;
                });

                // If the movie is marked as a favorite, add it to the favorites list
                if (isFavorite) {
                  // Here, you should add your movie data to a list of favorite movies.
                  // You can use a global list or a state management solution for this.
                  // For simplicity, I'll demonstrate adding it to a global list here.
                  favoritesList.add(widget.movie!);
                } else {
                  // If it's no longer a favorite, remove it from the favorites list.
                  favoritesList.remove(widget.movie);
                }
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: widget.movie != null
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            Image.network(
              'https://image.tmdb.org/t/p/w500/${widget.movie!['poster_path'] ?? ''}',
              width: double.infinity,
              height: 600,
              fit: BoxFit.cover,
            ),

            // Movie Overview
            SizedBox(height: 16),
            Text(
              'Overview:',
              style: TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 18,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              widget.movie!['overview'] ?? 'No overview available',
              style: TextStyle(
                color: Color(0xFF4B95DD),
                fontSize: 12,
                fontFamily: 'Gotham Light',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Vote Average:',
                  style: TextStyle(
                    color: Color(0xFF2196F3),
                    fontSize: 14,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Color(0xFF2196F3), // Star color
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  widget.movie!['vote_average'] != null
                      ? widget.movie!['vote_average'].toStringAsFixed(1)
                      : 'N/A',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),

            // Release Date
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Release Date:',
                  style: TextStyle(
                    color: Color(0xFF2196F3),
                    fontSize: 14,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  widget.movie!['release_date'] ?? 'Unknown',
                  style: TextStyle(
                    color: Color(0xFF2196F3),
                    fontSize: 12,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            // Top Cast
            SizedBox(height: 16),
            Text(
              'Top Cast:',
              style: TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 14,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w700,
              ),
            ),

// Display top cast members with photos and names
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topCast.length,
                itemBuilder: (context, index) {
                  final castMember = topCast[index];
                  final actorName = castMember['name'] ?? 'Unknown';
                  final actorPhotoUrl = castMember['profile_path'] != null
                      ? 'https://image.tmdb.org/t/p/w185/${castMember['profile_path']}'
                      : 'https://example.com/placeholder.jpg'; // Use a placeholder image URL if no photo is available

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(actorPhotoUrl),
                      ),
                      SizedBox(height: 4),
                      Text(actorName),
                    ],
                  );
                },
              ),
            ),

            // Comments
            SizedBox(height: 16),
            Text(
              'Comments:',
              style: TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 14,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w700,
              ),
            ),
            // Add comments or reviews here

            // Add ratings information here

            // Add more movie details as needed
          ],
        )
            : Center(
          child: Text('Movie data not available.'),
        ),
      ),
    );
  }
}

// This is a global list to store favorite movies.
List<Map<String, dynamic>> favoritesList = [];

// Define your FavoritesPage class here
