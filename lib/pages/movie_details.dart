import 'package:flutter/material.dart';
import 'package:flick_go/model/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? movie;

  MovieDetailScreen({required this.movie});


  @override
  Widget build(BuildContext context) {
    if (movie == null) {
      // Handle the case where movie data is null
      return Scaffold(
        appBar: AppBar(
          title: Text('Movie Details'),
          backgroundColor: Color.fromRGBO(33, 150, 243, 1),
        ),
        body: Center(
          child: Text('Movie data not available.'),
        ),
      );
    }

    final List<Map<String, dynamic>> topCast =
        movie!['credits']?['cast'] as List<Map<String, dynamic>>? ?? [];
    final double? rating = movie!['rating'];
    final String ratingString = rating != null ? rating.toStringAsFixed(1) : 'N/A';
    return Scaffold(
      appBar: AppBar(
        title: Text(movie!['title'] ?? 'Movie Details'),
        backgroundColor: Color.fromRGBO(33, 150, 243, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            Image.network(
              'https://image.tmdb.org/t/p/w500/${movie!['poster_path'] ?? ''}',
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
                height: 0,
              ),
            ),
            Text(
              movie!['overview'] ?? 'No overview available',
              style: TextStyle(
                color: Color(0xFF4B95DD),
                fontSize: 12,
                fontFamily: 'Gotham Light',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Vote Average:',
                  style: TextStyle(
                    color: Color(0xFF2196F3),
                    fontSize: 14,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                Icon(
                  Icons.favorite, // You can use a star icon for the vote average
                  color: Color(0xFF2196F3), // Star color
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  movie!['vote_average'] != null
                      ? movie!['vote_average'].toStringAsFixed(1)
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
                    height: 0,
                  ),
                ),
                Text(
                  movie!['release_date'] ?? 'Unknown',
                  style: TextStyle(
                    color: Color(0xFF2196F3),
                    fontSize: 12,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w700,
                    height: 0,
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
                height: 0,
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
                height: 0,
              ),
            ),
            // Add comments or reviews here

            // Add ratings information here

            // Add more movie details as needed
          ],
        ),
      ),
    );
  }
}
