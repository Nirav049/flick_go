// import 'package:get_it/get_it.dart';
// import '../services/http_services.dart';
// import '../model/movie.dart';
// import 'package:dio/dio.dart';
//
// class MovieService {
//   final GetIt getIt = GetIt.instance;
//
//   late HTTPService _http;
//
//   MovieService() {
//     _http = getIt.get<HTTPService>();
//   }
//
//   Future<List<Movie>?> getPopularMovies({int? page}) async {
//     Response? _response = await _http.get('/movie/popular', query: {
//       'page': page,
//     });
//     if (_response!.statusCode == 200) {
//       Map _data = _response.data;
//       List<Movie>? _movie = _data['results'].map<Movie>((_movieData) {
//         return Movie.fromJson(_movieData);
//       }).toList();
//       return _movie;
//     } else {
//       throw Exception('Couldn\'t load popular movies.');
//     }
//   }
//
//   Future<List<Movie>?> getUpcomingMovies({int? page}) async {
//     Response? _response = await _http.get('/movie/upcoming', query: {
//       'page': page,
//     });
//     if (_response!.statusCode == 200) {
//       Map _data = _response.data;
//       List<Movie>? _movie = _data['results'].map<Movie>((_movieData) {
//         return Movie.fromJson(_movieData);
//       }).toList();
//       return _movie;
//     } else {
//       throw Exception('Couldn\'t load upcoming movies.');
//     }
//   }
//
//   Future<List<Movie>?> searchMovies(String? _seachTerm, {int? page}) async {
//     Response? _response = await _http.get('/search/movie', query: {
//       'query': _seachTerm,
//       'page': page,
//     });
//     if (_response!.statusCode == 200) {
//       Map _data = _response.data;
//       List<Movie>? _movie = _data['results'].map<Movie>((_movieData) {
//         return Movie.fromJson(_movieData);
//       }).toList();
//       return _movie;
//     } else {
//       throw Exception('Couldn\'t perform movies search.');
//     }
//   }
// }
