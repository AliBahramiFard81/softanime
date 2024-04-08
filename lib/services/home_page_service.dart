import 'dart:convert';
import 'package:main/models/anime_manga_genre_model.dart';
import 'package:main/models/anime_popular_episodes_model.dart';
import 'package:main/models/anime_quotes_model.dart';
import 'package:main/models/home_page_model.dart';
import 'package:main/models/random_anime_model.dart';
import 'package:main/models/recent_anime_episodes_model.dart';
import 'package:main/models/recommended_anime_manga_model.dart';
import 'package:main/models/top_actors_model.dart';
import 'package:main/models/top_anime_manga_model.dart';
import 'package:main/models/top_character_model.dart';
import 'package:main/models/top_reviews_model.dart';
import 'package:http/http.dart' as http;

class HomePageService {
  Future<HomePageModel?> getHomePageContent() async {
    // URLs
    const randomUrl = 'https://api.jikan.moe/v4/random/anime';
    const recommendedAnimeUrl =
        'https://api.jikan.moe/v4/recommendations/anime';
    const topAnimeUrl = 'https://api.jikan.moe/v4/top/anime?page=1';
    const recommendedMangaUrl =
        'https://api.jikan.moe/v4/recommendations/manga';
    const topMangaUrl = 'https://api.jikan.moe/v4/top/manga';
    const animeGenreUrl = 'https://api.jikan.moe/v4/genres/anime';
    const mangaGenreUrl = 'https://api.jikan.moe/v4/genres/manga';
    const topCharactersUrl = 'https://api.jikan.moe/v4/top/characters';
    const topActorsUrl = 'https://api.jikan.moe/v4/top/people';
    const topReviewUrl = 'https://api.jikan.moe/v4/top/reviews';
    const animeQuotesUrl = 'https://animechan.xyz/api/quotes';
    const recentEpisodesUrl = 'https://api.jikan.moe/v4/watch/episodes';
    const popularAnimeEpisodesUrl =
        'https://api.jikan.moe/v4/watch/episodes/popular';
    try {
      // RANDOM ANIME SERVICE
      final randomResponse1 = await http.get(Uri.parse(randomUrl));
      final randomResponse2 = await http.get(Uri.parse(randomUrl));
      final randomResponse3 = await http.get(Uri.parse(randomUrl));

      final randomModel = [
        RandomAnimeModel.fromJson(jsonDecode(randomResponse1.body)),
        RandomAnimeModel.fromJson(jsonDecode(randomResponse2.body)),
        RandomAnimeModel.fromJson(jsonDecode(randomResponse3.body)),
      ];

      await Future.delayed(const Duration(seconds: 1));

      // RECOMMENDED ANIME SERVICE
      final recommendedResponse =
          await http.get(Uri.parse(recommendedAnimeUrl));
      final recommendedModel = List.generate(
        (jsonDecode(recommendedResponse.body)['data'] as List<dynamic>).length *
            2,
        (index) => RecommendedAnimeMangaModel.fromJson(
          jsonDecode(recommendedResponse.body),
          (index / 2).floor(),
          index.isEven ? 0 : 1,
          (jsonDecode(recommendedResponse.body))['pagination']['has_next_page'],
        ),
      );

      // TOP ANIME SERVICE
      final topAnimeResponse = await http.get(Uri.parse(topAnimeUrl));
      final topAnimeModel = List.generate(10, (index) {
        return TopAnimeMangaModel.fromJson(
          jsonDecode(topAnimeResponse.body)['data'][index],
          (jsonDecode(recommendedResponse.body))['pagination']['has_next_page'],
        );
      });

      // RECOMMENDED MANGA SERVICE
      final recommendedMangaResponse =
          await http.get(Uri.parse(recommendedMangaUrl));
      final recommendedMangaModel = List.generate(
        (jsonDecode(recommendedMangaResponse.body)['data'] as List<dynamic>)
                .length *
            2,
        (index) => RecommendedAnimeMangaModel.fromJson(
          jsonDecode(recommendedMangaResponse.body),
          (index / 2).floor(),
          index.isEven ? 0 : 1,
          (jsonDecode(recommendedMangaResponse.body))['pagination']
              ['has_next_page'],
        ),
      );

      await Future.delayed(const Duration(seconds: 1));

      // TOP MANGA SERVICE
      final topMangaResponse = await http.get(Uri.parse(topMangaUrl));
      final topMangaModel = List.generate(10, (index) {
        return TopAnimeMangaModel.fromJson(
          jsonDecode(topMangaResponse.body)['data'][index],
          (jsonDecode(recommendedResponse.body))['pagination']['has_next_page'],
        );
      });

      // GENRE SERVICE
      final genreResponse = await Future.wait([
        http.get(Uri.parse(animeGenreUrl)),
        http.get(Uri.parse(mangaGenreUrl)),
      ]);
      final animeGenreModel = List.generate(20, (index) {
        return AnimeMangaGenreModel.fromJson(
            jsonDecode(genreResponse[0].body)['data'][index]);
      });

      final mangaGenreModel = List.generate(20, (index) {
        return AnimeMangaGenreModel.fromJson(
            jsonDecode(genreResponse[1].body)['data'][index]);
      });

      await Future.delayed(const Duration(seconds: 1));

      // TOP CHARACTERS
      final topCharacterResponse = await http.get(Uri.parse(topCharactersUrl));
      final topCharacterModel = List.generate(10, (index) {
        return TopCharacterModel.fromJson(
            jsonDecode(topCharacterResponse.body)['data'][index]);
      });

      // TOP ACTORS
      final topActorsResponse = await http.get(Uri.parse(topActorsUrl));
      final topActorsModel = List.generate(10, (index) {
        return TopActorsModel.fromJson(
            jsonDecode(topActorsResponse.body)['data'][index]);
      });

      // TOP REVIEWS
      final topReviewsResponse = await http.get(Uri.parse(topReviewUrl));
      final topReviewsModel = List.generate(10, (index) {
        return TopReviewsModel.fromJson(
            jsonDecode(topReviewsResponse.body)['data'][index]);
      });

      // ANIME QUOTES SERVICE
      final animeQuoteResponse = await http.get(Uri.parse(animeQuotesUrl));
      final animeQuoteModel = List.generate(10, (index) {
        return AnimeQuotesModel.fromJson(
            jsonDecode(animeQuoteResponse.body)[index]);
      });

      await Future.delayed(const Duration(seconds: 1));

      //  RECENT ANIME EPISODES SERVICE
      final resentAnimeEpisodesResponse =
          await http.get(Uri.parse(recentEpisodesUrl));
      final recentAnimeEpisodeModel = List.generate(10, (index) {
        return RecentAnimeEpisodesModel.fromJson(
          jsonDecode(resentAnimeEpisodesResponse.body)['data'][index],
          (jsonDecode(resentAnimeEpisodesResponse.body))['pagination']
              ['has_next_page'],
        );
      });

      // POPULAR ANIME EPISODES SERVICE
      final popularAnimeEpisodeResponse =
          await http.get(Uri.parse(popularAnimeEpisodesUrl));
      final popularAnimeEpisodeModel = List.generate(10, (index) {
        return AnimePopularEpisodeModel.fromJson(
          jsonDecode(popularAnimeEpisodeResponse.body)['data'][index],
          (jsonDecode(resentAnimeEpisodesResponse.body))['pagination']
              ['has_next_page'],
        );
      });

      return HomePageModel(
        randomAnimeModel: randomModel,
        recommendedAnimeModel: recommendedModel,
        topAnimeModel: topAnimeModel,
        recommendedMangaModel: recommendedMangaModel,
        topMangaModel: topMangaModel,
        animeGenreModel: animeGenreModel,
        mangaGenreModel: mangaGenreModel,
        topCharacterModel: topCharacterModel,
        topActorModel: topActorsModel,
        topReviewsModel: topReviewsModel,
        animeQuotesModel: animeQuoteModel,
        recentAnimeEpisodeModel: recentAnimeEpisodeModel,
        popularAnimeEpisodeModel: popularAnimeEpisodeModel,
      );
    } catch (e) {
      // ignore: cast_from_null_always_fails
      print(e.toString());
      return null;
    }
  }
}
