import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:main/models/anime_manga_genre_model.dart';
import 'package:main/models/genre_page_model.dart';

class GenresService {
  Future<List<AnimeMangaGenreModel>?> getAllGenres(String type) async {
    final url = 'https://api.jikan.moe/v4/genres/$type';
    try {
      final response = await http.get(Uri.parse(url));
      final genresModel = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return AnimeMangaGenreModel.fromJson(
            jsonDecode(response.body)['data'][index]);
      });
      return genresModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<GenrePageModel>?> getGenreTitles(
      int id, String type, int page) async {
    final url = 'https://api.jikan.moe/v4/$type?genres=$id&page=$page';
    try {
      final response = await http.get(Uri.parse(url));
      final genreTitles = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return GenrePageModel.fromJson(
          jsonDecode(response.body)['data'][index],
          jsonDecode(response.body)['pagination']['has_next_page'],
        );
      });
      return genreTitles;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
