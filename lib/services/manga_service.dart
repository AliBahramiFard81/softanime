import 'dart:convert';

import 'package:http/http.dart' as http;
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
        return Characters.fromJson(
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
}
