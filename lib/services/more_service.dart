import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main/models/anime_popular_episodes_model.dart';
import 'package:main/models/recent_anime_episodes_model.dart';
import 'package:main/models/recommended_anime_manga_model.dart';
import 'package:main/models/top_anime_manga_model.dart';

class AnimeMangaMoreService {
  Future<List<RecommendedAnimeMangaModel>?> getRecommendedAnimeMore(
      int page) async {
    final url = 'https://api.jikan.moe/v4/recommendations/anime?page=$page';
    try {
      final response = await http.get(Uri.parse(url));
      final recommendedModel = List.generate(
        (jsonDecode(response.body)['data'] as List<dynamic>).length * 2,
        (index) => RecommendedAnimeMangaModel.fromJson(
          jsonDecode(response.body),
          (index / 2).floor(),
          index.isEven ? 0 : 1,
          (jsonDecode(response.body))['pagination']['has_next_page'],
        ),
      );

      return recommendedModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<TopAnimeMangaModel>?> getTopAnimeMore(int page) async {
    final url = 'https://api.jikan.moe/v4/top/anime?page=$page';
    try {
      final response = await http.get(Uri.parse(url));
      final topModel = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return TopAnimeMangaModel.fromJson(
          jsonDecode(response.body)['data'][index],
          (jsonDecode(response.body))['pagination']['has_next_page'],
        );
      });
      return topModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<RecentAnimeEpisodesModel>?> getRecentAnimeMore(int page) async {
    final url = 'https://api.jikan.moe/v4/watch/episodes?page=$page';
    try {
      final response = await http.get(Uri.parse(url));
      final recentModel = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return RecentAnimeEpisodesModel.fromJson(
          jsonDecode(response.body)['data'][index],
          (jsonDecode(response.body))['pagination']['has_next_page'],
        );
      });
      return recentModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<AnimePopularEpisodeModel>?> getPopularAnimeMore(int page) async {
    final url = 'https://api.jikan.moe/v4/watch/episodes/popular?page=$page';
    try {
      final response = await http.get(Uri.parse(url));
      final popularModel = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return AnimePopularEpisodeModel.fromJson(
          jsonDecode(response.body)['data'][index],
          (jsonDecode(response.body))['pagination']['has_next_page'],
        );
      });
      return popularModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<RecommendedAnimeMangaModel>?> getRecommendedMangaMore(
      int page) async {
    final url = 'https://api.jikan.moe/v4/recommendations/manga?page=$page';
    try {
      final response = await http.get(Uri.parse(url));
      final recommendedModel = List.generate(
        (jsonDecode(response.body)['data'] as List<dynamic>).length * 2,
        (index) => RecommendedAnimeMangaModel.fromJson(
          jsonDecode(response.body),
          (index / 2).floor(),
          index.isEven ? 0 : 1,
          (jsonDecode(response.body))['pagination']['has_next_page'],
        ),
      );

      return recommendedModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<TopAnimeMangaModel>?> getTopMangaMore(int page) async {
    final url = 'https://api.jikan.moe/v4/top/manga?page=$page';
    try {
      final response = await http.get(Uri.parse(url));
      final topModel = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return TopAnimeMangaModel.fromJson(
          jsonDecode(response.body)['data'][index],
          (jsonDecode(response.body))['pagination']['has_next_page'],
        );
      });
      return topModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
