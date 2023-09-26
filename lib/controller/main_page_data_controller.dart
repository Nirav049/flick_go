// //Package
// import 'dart:async';
//
// import '../model/search_catagory.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get_it/get_it.dart';
//
// //Models
// import '../model/main_page_data.dart';
// import '../model/movie.dart';
//
// //Services
// import '../services/movie_services.dart';
//
// class MainPageDataController extends StateNotifier<MainPageData> {
//   MainPageDataController([MainPageData? state])
//       : super(state ?? MainPageData.inital()) {
//     getMovies();
//   }
//
//   final MovieService _movieService = GetIt.instance.get<MovieService>();
//
//   Future<void> getMovies() async {
//     try {
//       List<Movie>? _movie = [];
//
//       if (state.searchText.isEmpty) {
//         if (state.searchCategory == SearchCategory.popular) {
//           _movie = await (_movieService.getPopularMovies(page: state.page));
//         } else if (state.searchCategory == SearchCategory.upcoming) {
//           _movie = await (_movieService.getUpcomingMovies(page: state.page));
//         } else if (state.searchCategory == SearchCategory.none) {
//           _movie = [];
//         }
//       } else {
//         _movie = await (_movieService.searchMovies(state.searchText));
//       }
//       state = state.copyWith(
//           movie : [...state.movie, ..._movie!], page: state.page + 1);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   void updateSearchCategory(String? _category) {
//     try {
//       state = state.copyWith(
//           movie: [], page: 1, searchCategory: _category, searchText: '');
//       getMovies();
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   void updateTextSearch(String _searchText) {
//     try {
//       state = state.copyWith(
//           movie: [],
//           page: 1,
//           searchCategory: SearchCategory.none,
//           searchText: _searchText);
//       getMovies();
//     } catch (e) {
//       print(e);
//     }
//   }
// }