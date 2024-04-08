import 'dart:convert';
import 'package:main/models/anime_model.dart';
import 'package:http/http.dart' as http;

class AnimePageService {
  final int id;
  AnimePageService({required this.id});

  Future<AnimeMainModel?> getAnime() async {
    final url = 'https://api.jikan.moe/v4/anime/$id';
    final animeCharacterUrl = 'https://api.jikan.moe/v4/anime/$id/characters';
    final recommendationsUrl =
        'https://api.jikan.moe/v4/anime/$id/recommendations';
    try {
      final animeResponse = await http.get(Uri.parse(url));
      final animeModel =
          AnimeModel.fromJson(jsonDecode(animeResponse.body)['data']);

      final characterResponse = await http.get(Uri.parse(animeCharacterUrl));
      final animeCharacterModel = List.generate(
          (jsonDecode(characterResponse.body)['data'] as List<dynamic>).length,
          (index) {
        if ((jsonDecode(characterResponse.body)['data'][index]['voice_actors']
                as List<dynamic>)
            .isNotEmpty) {
          return Characters.fromJson(
              jsonDecode(characterResponse.body)['data'][index], true);
        } else {
          return Characters.fromJson(
              jsonDecode(characterResponse.body)['data'][index], false);
        }
      });
      animeCharacterModel.removeWhere((element) => element.actorImage == '');

      final recommendationResponse =
          await http.get(Uri.parse(recommendationsUrl));

      final recommendationsModel = List.generate(
          (jsonDecode(recommendationResponse.body)['data'] as List<dynamic>)
              .length, (index) {
        return AnimeRecommendations.fromJson(
            jsonDecode(recommendationResponse.body)['data'][index]['entry']);
      });
      return AnimeMainModel(
        animeModel: animeModel,
        characters: animeCharacterModel,
        recommendations: recommendationsModel,
      );
    } catch (e) {
      return null;
    }
  }

  Future<List<AnimeEpisodeModel>?> getAnimeEpisodes(int page) async {
    final url = 'https://api.jikan.moe/v4/anime/$id/episodes?page=$page';
    try {
      final response = await http.get(Uri.parse(url));
      final episodesModel = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return AnimeEpisodeModel.fromJson(
          jsonDecode(response.body)['data'][index],
          jsonDecode(response.body)['pagination']['has_next_page'],
        );
      });

      return episodesModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<AnimeEpisodeDetailsModel?> getAnimeEpisodeDetails(int episode) async {
    final url = 'https://api.jikan.moe/v4/anime/$id/episodes/$episode';
    try {
      final response = await http.get(Uri.parse(url));
      final episodeDetailsModel =
          AnimeEpisodeDetailsModel.fromJson(jsonDecode(response.body)['data']);
      return episodeDetailsModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<AnimeImageGalleryModel>?> getAnimeImageGallery() async {
    final url = 'https://api.jikan.moe/v4/anime/$id/pictures';
    try {
      final response = await http.get(Uri.parse(url));
      final imageGalleryModel = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return AnimeImageGalleryModel.fromJson(
            jsonDecode(response.body)['data'][index]);
      });
      return imageGalleryModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<AnimeVideoGalleryModel>?> getAnimeVideoGallery() async {
    final url = 'https://api.jikan.moe/v4/anime/$id/videos';
    try {
      final response = await http.get(Uri.parse(url));
      List<AnimeVideoGalleryModel> videoGalleryModel = [];

      final promoVideos = List.generate(
          (jsonDecode(response.body)['data']['promo'] as List<dynamic>).length,
          (index) {
        return AnimeVideoGalleryModel.fromJson(
          jsonDecode(response.body)['data']['promo'][index],
          0,
        );
      });
      final musicVideos = List.generate(
          (jsonDecode(response.body)['data']['music_videos'] as List<dynamic>)
              .length, (index) {
        return AnimeVideoGalleryModel.fromJson(
          jsonDecode(response.body)['data']['music_videos'][index],
          1,
        );
      });
      videoGalleryModel.addAll(promoVideos);
      videoGalleryModel.addAll(musicVideos);

      return videoGalleryModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<AnimeReviewsModel>?> getAnimeReviews(int page) async {
    final url = 'https://api.jikan.moe/v4/anime/$id/reviews?page=$page';
    try {
      final response = await http.get(Uri.parse(url));
      final reviewsModel = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return AnimeReviewsModel.fromJson(
          jsonDecode(response.body)['data'][index],
          jsonDecode(response.body)['pagination']['has_next_page'],
        );
      });
      return reviewsModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
