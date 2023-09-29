import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flick_go/navigationBar.dart';
import 'package:flick_go/pages/movie_details.dart';
import 'package:flick_go/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  double? _deviceHeight;
  double? _deviceWidth;

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
        leading: Container(
          height: 100,
          width: 100,
          child: Image.asset(
            'assets/images/icons/Flick GO.png',
            fit: BoxFit.cover,
          ),
        ),
        actions: [
          Builder(builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/icons/profile.png',
                ),
              ),
            );
          })
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      endDrawer: _sideBar(BuildContext),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => _buildTrending(
                  context,
                ), // Pass both context and movies
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _currentIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }

  Widget _buildTrending(BuildContext context) {
    TextStyle heading = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Color.fromRGBO(33, 150, 243, 1),
    );
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Trending Now section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Trending Now",
                style: heading,
              ),
              Text(
                "see all",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(33, 150, 243, 1),
                ),
              ),
            ],
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchTrendingMovies(),
            builder: (context, trendingSnapshot) {
              if (trendingSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show a loading indicator while fetching data.
              } else if (trendingSnapshot.hasError) {
                return Text('Error: ${trendingSnapshot.error}');
              } else if (!trendingSnapshot.hasData ||
                  trendingSnapshot.data!.isEmpty) {
                return Text('No trending movies available.');
              } else {
                final trendingMovies = trendingSnapshot.data;

                return SizedBox(

                  child: CarouselSlider.builder(
                    itemCount: trendingMovies!.length,
                    itemBuilder: (context, index, realIndex) {
                      final movie = trendingMovies[index];
                      final movieTitle = movie['title'];
                      final posterPath = movie['poster_path'];
                      final posterUrl =
                          'https://image.tmdb.org/t/p/w185$posterPath';

                      return InkWell(
                        onTap: () {
                          // Handle movie selection
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailScreen(movie: movie), // Pass the selected movie
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            padding: EdgeInsets.symmetric(
                                vertical: _deviceHeight! * 0.01, horizontal: 1),
                            width: 130,
                            height: 160,
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: posterUrl,
                                  height: _deviceHeight! * 0.20,
                                  width: _deviceWidth! * 0.85,
                                fit: BoxFit.cover,
                              ),

                              // Text(
                              //   movieTitle,
                              //   style:
                              //   TextStyle(fontSize: 15, color: Colors.black),
                              //   textAlign: TextAlign.center,
                              // ),
                            ],
                          ),
                        ),
                        ),

                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 0.30,
                      enlargeCenterPage: true,
                      pageSnapping: true,
                      autoPlay: true, // Set autoPlay to true
                      autoPlayInterval: Duration(seconds: 3), // Set autoPlay interval
                      autoPlayAnimationDuration: Duration(milliseconds: 800), // Animation duration
                      autoPlayCurve: Curves.fastOutSlowIn, // Animation curve
                    ),
                  ),
                );
              }
            },
          ),

          // Popular Movies Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "popular",
                style: heading,
              ),
              Text(
                "see all",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(33, 150, 243, 1),
                ),
              ),
            ],
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchPopularMovies(),
            builder: (context, popularSnapshot) {
              if (popularSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show a loading indicator while fetching data.
              } else if (popularSnapshot.hasError) {
                return Text('Error: ${popularSnapshot.error}');
              } else if (!popularSnapshot.hasData ||
                  popularSnapshot.data!.isEmpty) {
                return Text('No popular movies available.');
              } else {
                final popularMovies = popularSnapshot.data;

                return SizedBox(
                  height: 251,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularMovies!.length,
                    itemBuilder: (context, index) {
                      final movie = popularMovies[index];
                      final movieTitle = movie['title'];
                      final posterPath = movie['poster_path'];

                      final posterUrl =
                          'https://image.tmdb.org/t/p/w185$posterPath';

                      return InkWell(
                        onTap: () {
                          // Handle movie selection
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(movie: movie), // Pass the selected movie
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          padding: EdgeInsets.symmetric(
                              vertical: _deviceHeight! * 0.01, horizontal: 0),
                          width: 130,
                          height: 160,
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: posterUrl,
                                height: _deviceHeight! * 0.20,
                                width: _deviceWidth! * 0.85,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 1),
                              Text(
                                movieTitle,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
          //upcoming section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "upcoming",
                style: heading,
              ),
              Text(
                "see all",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(33, 150, 243, 1),
                ),
              ),
            ],
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchUpcomingMovies(),
            builder: (context, upcomingSnapshot) {
              if (upcomingSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show a loading indicator while fetching data.
              } else if (upcomingSnapshot.hasError) {
                return Text('Error: ${upcomingSnapshot.error}');
              } else if (!upcomingSnapshot.hasData ||
                  upcomingSnapshot.data!.isEmpty) {
                return Text('No upcoming movies available.');
              } else {
                final upcomingMovies = upcomingSnapshot.data;

                return SizedBox(
                  height: 255,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: upcomingMovies!.length,
                    itemBuilder: (context, index) {
                      final movie = upcomingMovies[index];
                      final movieTitle = movie['title'];
                      final posterPath = movie['poster_path'];

                      final posterUrl =
                          'https://image.tmdb.org/t/p/w185$posterPath';

                      return InkWell(
                        onTap: () {
                          // Handle movie selection
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(movie: movie), // Pass the selected movie
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          padding: EdgeInsets.symmetric(
                              vertical: _deviceHeight! * 0.01, horizontal: 1),
                          width: 130,
                          height: 160,
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: posterUrl,
                                height: _deviceHeight! * 0.20,
                                width: _deviceWidth! * 0.85,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 4),
                              Text(
                                movieTitle,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    ]);
  }

  Widget _sideBar(BuildContext) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Your Name'),
              accountEmail: Text('youremail@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/images/icons/profile.png"), // Replace with your image
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(33, 150, 243, 1),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Rated by you",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < 5; i++)
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            color: Colors.brown.shade400,
                            width: 75,
                            child: Center(
                              child: Text(
                                (i + 1).toString(),
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to the settings page
              },
            ),
            // Add more drawer items as needed
          ],
        ),
      ),
    );
  }
}
