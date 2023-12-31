import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flick_go/navigationBar.dart';
import 'package:flick_go/pages/movie_details.dart';
import 'package:flick_go/pages/profile.dart';
import 'package:flick_go/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  double? _deviceHeight;
  double? _deviceWidth;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: Container(
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
                  backgroundImage: NetworkImage(user?.photoURL ?? ''),
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
    return Column(
      children: [
        Column(
          children: [
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
            SizedBox(
              height: 190, // Fixed height for the CarouselSlider
              child: SingleChildScrollView(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchTrendingMovies(),
                  builder: (context, trendingSnapshot) {
                    if (trendingSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (trendingSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${trendingSnapshot.error}'));
                    } else if (!trendingSnapshot.hasData ||
                        trendingSnapshot.data!.isEmpty) {
                      return Center(
                          child: Text('No trending movies available.'));
                    } else {
                      final trendingMovies = trendingSnapshot.data;

                      return CarouselSlider.builder(
                        itemCount: trendingMovies!.length,
                        itemBuilder: (context, index, realIndex) {
                          final movie = trendingMovies[index];
                          final movieTitle = movie['title'];
                          final posterPath = movie['poster_path'];
                          final posterUrl =
                              'https://image.tmdb.org/t/p/w185$posterPath';

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailScreen(movie: movie),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: posterUrl,
                                      height: 140,
                                      width: 220,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(height: 1),
                                  Text(
                                    movieTitle,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                    textAlign: TextAlign.center,
                                    maxLines: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          viewportFraction: 0.65,
                          enlargeCenterPage: true,
                          pageSnapping: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
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
                fontSize: 12,
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
                height: 281,
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
                            builder: (context) => MovieDetailScreen(
                                movie: movie), // Pass the selected movie
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
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
                height: 281,
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
                            builder: (context) => MovieDetailScreen(
                                movie: movie), // Pass the selected movie
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
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
    );
  }

  Widget _sideBar(BuildContext) {
    User? user = _auth.currentUser;
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(' ${user?.displayName ?? ''}'),
              accountEmail: Text('${user?.email ?? ''}'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user?.photoURL ?? ''),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(33, 150, 243, 1),
              ),
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text('Go To Profile'),
              onTap: () {
                // Navigate to the settings page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfilePage(), // Pass the selected movie
                  ),
                );
              },
            ),
            // Add more drawer items as needed
          ],
        ),
      ),
    );
  }
}
