import 'package:main/models/anime_manga_genre_model.dart';
import 'package:main/models/anime_popular_episodes_model.dart';
import 'package:main/models/anime_quotes_model.dart';
import 'package:main/models/random_anime_model.dart';
import 'package:main/models/recent_anime_episodes_model.dart';
import 'package:main/models/recommended_anime_manga_model.dart';
import 'package:main/models/top_actors_model.dart';
import 'package:main/models/top_anime_manga_model.dart';
import 'package:main/models/top_character_model.dart';
import 'package:main/models/top_reviews_model.dart';

class HomePageModel {
  final List<RandomAnimeModel> randomAnimeModel;
  final List<RecommendedAnimeMangaModel> recommendedAnimeModel;
  final List<TopAnimeMangaModel> topAnimeModel;
  final List<RecommendedAnimeMangaModel> recommendedMangaModel;
  final List<TopAnimeMangaModel> topMangaModel;
  final List<AnimeMangaGenreModel> animeGenreModel;
  final List<AnimeMangaGenreModel> mangaGenreModel;
  final List<TopCharacterModel> topCharacterModel;
  final List<TopActorsModel> topActorModel;
  final List<TopReviewsModel> topReviewsModel;
  final List<AnimeQuotesModel> animeQuotesModel;
  final List<RecentAnimeEpisodesModel> recentAnimeEpisodeModel;
  final List<AnimePopularEpisodeModel> popularAnimeEpisodeModel;
  HomePageModel({
    required this.randomAnimeModel,
    required this.recommendedAnimeModel,
    required this.topAnimeModel,
    required this.recommendedMangaModel,
    required this.topMangaModel,
    required this.animeGenreModel,
    required this.mangaGenreModel,
    required this.topCharacterModel,
    required this.topActorModel,
    required this.topReviewsModel,
    required this.animeQuotesModel,
    required this.recentAnimeEpisodeModel,
    required this.popularAnimeEpisodeModel,
  });
}
