import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Movie_tiles extends StatelessWidget {

  final GetIt getIt   = GetIt.instance;
  final double height;
  final double width;
  late final movie;

  Movie_tiles({required this.height,required this.width,this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _moviePosterWidget(movie.posterURL()),
          //_movieInfoWidget(),
        ],
      ),
    );
  }

  Widget _moviePosterWidget(String _imageUrl) {
    return Container(
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_imageUrl),
        ),
      ),
    );
  }
}
