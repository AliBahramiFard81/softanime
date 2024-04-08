import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:main/models/anime_characters_actors_model.dart';

class AnimeCharactersActorsService {
  final int id;
  AnimeCharactersActorsService({required this.id});

  Future<AnimeCharactersMainModel?> getAnimeCharacter() async {
    final url = 'https://api.jikan.moe/v4/characters/$id/full';
    try {
      final response = await http.get(Uri.parse(url));
      final characterModel =
          AnimeCharacter.fromJson(jsonDecode(response.body)['data']);

      final characterAnime = List.generate(
          (jsonDecode(response.body)['data']['anime'] as List<dynamic>).length,
          (index) {
        return AnimeCharacterAnime.fromJson(
            jsonDecode(response.body)['data']['anime'][index]['anime']);
      });

      final characterManga = List.generate(
          (jsonDecode(response.body)['data']['manga'] as List<dynamic>).length,
          (index) {
        return AnimeCharacterManga.fromJson(
            jsonDecode(response.body)['data']['manga'][index]['manga']);
      });

      final characterActor = List.generate(
          (jsonDecode(response.body)['data']['voices'] as List<dynamic>).length,
          (index) {
        return AnimeCharacterActor.fromJson(
            jsonDecode(response.body)['data']['voices'][index]['person']);
      });

      final characterMainModel = AnimeCharactersMainModel(
        animeCharacter: characterModel,
        animeCharacterAnime: characterAnime,
        animeCharacterManga: characterManga,
        animeCharacterActor: characterActor,
      );

      return characterMainModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<AnimeCharacterImageModel>?> getCharactersImage() async {
    final url = 'https://api.jikan.moe/v4/characters/$id/pictures';
    try {
      final response = await http.get(Uri.parse(url));
      final imageGallery = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return AnimeCharacterImageModel.fromJson(
            jsonDecode(response.body)['data'][index]);
      });
      return imageGallery;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
