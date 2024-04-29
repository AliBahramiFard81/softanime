import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:main/models/anime_model.dart';
import 'package:main/models/manga_model.dart';

class MangaService {
  final int id;
  MangaService({required this.id});

  Future<MangaMainModel?> getManga() async {
    final url = 'https://api.jikan.moe/v4/manga/$id';
    final mangaCharacterUrl = 'https://api.jikan.moe/v4/manga/$id/characters';
    final mangaRecommendationsUrl =
        'https://api.jikan.moe/v4/manga/$id/recommendations';
    try {
      final response = await http.get(Uri.parse(url));
      final mangaModel = MangaModel.fromJson(jsonDecode(response.body)['data']);

      final charactersResponse = await http.get(Uri.parse(mangaCharacterUrl));
      final charactersModel = List.generate(
          (jsonDecode(charactersResponse.body)['data'] as List<dynamic>).length,
          (index) {
        return MangaCharacters.fromJson(
            jsonDecode(charactersResponse.body)['data'][index]);
      });

      final recommendationsResponse =
          await http.get(Uri.parse(mangaRecommendationsUrl));
      final recommendationsModel = List.generate(
          (jsonDecode(recommendationsResponse.body)['data'] as List<dynamic>)
              .length, (index) {
        return MangaRecommendations.fromJson(
            jsonDecode(recommendationsResponse.body)['data'][index]['entry']);
      });
      final mangaMainModel = MangaMainModel(
        mangaModel: mangaModel,
        charactersModel: charactersModel,
        mangaRecommendations: recommendationsModel,
      );

      return mangaMainModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<MangaImageGalleryModel>?> getMangaImageGallery() async {
    final url = 'https://api.jikan.moe/v4/manga/$id/pictures';
    try {
      final response = await http.get(Uri.parse(url));
      final images = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return MangaImageGalleryModel.fromJson(
            jsonDecode(response.body)['data'][index]);
      });
      return images;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<AnimeReviewsModel>?> getMangaReviews() async {
    final url = 'https://api.jikan.moe/v4/manga/$id/reviews';
    try {
      final response = await http.get(Uri.parse(url));
      final reviews = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return AnimeReviewsModel.fromJson(
          jsonDecode(response.body)['data'][index],
          jsonDecode(response.body)['pagination']['has_next_page'],
        );
      });
      return reviews;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
