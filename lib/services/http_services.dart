// import '../model/app_config.dart';
//
//
// //Packages
// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
//
// class HTTPService {
//   final Dio dio = Dio();
//   final GetIt getIt = GetIt.instance;
//
//   String? _base_url;
//   String? _api_key;
//
//   HTTPService() {
//     AppConfig _config = getIt.get<AppConfig>();
//     _base_url = _config.BASE_API_URL;
//     _api_key = _config.API_KEY;
//   }
//
//   Future<Response?> get(String _path, {Map<String, dynamic>? query}) async {
//     try {
//       String _url = '$_base_url$_path';
//       Map<String, dynamic> _query = {
//         'api_key': _api_key,
//         'language': 'en-US',
//       };
//       if (query != null) {
//         _query.addAll(query);
//       }
//       return await dio.get(_url, queryParameters: _query);
//     } on DioError catch (e) {
//       print('Unable to perform get request.');
//       print('DioError:$e');
//     }
//   }
// }
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '92a3819765c0405b6fd4199a163d60ad';

Future<List<Map<String, dynamic>>> fetchTrendingMovies() async {

  final response = await http.get(
    Uri.parse('https://api.themoviedb.org/3/trending/movie/day?api_key=$apiKey'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> results = data['results'];
    return results.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load trending movies');
  }
}

Future<List<Map<String, dynamic>>> fetchPopularMovies() async {

  final response = await http.get(
    Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> results = data['results'];
    return results.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load popular movies');
  }
}

Future<List<Map<String, dynamic>>> fetchUpcomingMovies() async {

  final response = await http.get(
    Uri.parse('https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> results = data['results'];
    return results.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load upcoming movies');
  }
}


