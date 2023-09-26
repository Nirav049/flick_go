import 'package:flick_go/model/search_catagory.dart';

import './movie.dart';


class MainPageData {
  final List<Movie> movie;
  final int page;
  final String searchCategory;
  final String searchText;

  MainPageData({required this.movie,required  this.page,required  this.searchCategory,required  this.searchText});

  MainPageData.inital()
      : movie = [],
        page = 1,
        searchCategory = SearchCategory.popular,
        searchText = '';

  MainPageData copyWith(
      {List<Movie>? movie,
        int? page,
        String? searchCategory,
        String? searchText}) {
    return MainPageData(
        movie: movie ?? this.movie,
        page: page ?? this.page,
        searchCategory: searchCategory ?? this.searchCategory,
        searchText: searchText ?? this.searchText);
  }
}
