part of 'more_bloc.dart';

@immutable
sealed class MoreEvent {}

final class GetMoreRecommendationAnime extends MoreEvent {
  final int page;
  GetMoreRecommendationAnime({required this.page});
}

final class GetMoreRecommendationAnimePagination extends MoreEvent {
  final int page;
  final List<RecommendedAnimeMangaModel> recommendedList;
  GetMoreRecommendationAnimePagination({
    required this.page,
    required this.recommendedList,
  });
}

final class GetMoreTopAnime extends MoreEvent {
  final int page;
  GetMoreTopAnime({required this.page});
}

final class GetMoreTopAnimePagination extends MoreEvent {
  final int page;
  final List<TopAnimeMangaModel> animeModel;
  GetMoreTopAnimePagination({required this.animeModel, required this.page});
}

final class GetMoreRecentAnimeEpisode extends MoreEvent {
  final int page;
  GetMoreRecentAnimeEpisode({required this.page});
}

final class GetMoreRecentAnimeEpisodePagination extends MoreEvent {
  final int page;
  final List<RecentAnimeEpisodesModel> recentModel;
  GetMoreRecentAnimeEpisodePagination({
    required this.page,
    required this.recentModel,
  });
}

final class GetMorePopularAnimeEpisode extends MoreEvent {
  final int page;
  GetMorePopularAnimeEpisode({required this.page});
}

final class GetMorePopularAnimeEpisodePagination extends MoreEvent {
  final int page;
  final List<AnimePopularEpisodeModel> popularModel;
  GetMorePopularAnimeEpisodePagination({
    required this.page,
    required this.popularModel,
  });
}

final class GetMoreRecommendationManga extends MoreEvent {
  final int page;
  GetMoreRecommendationManga({required this.page});
}

final class GetMoreRecommendationMangaPagination extends MoreEvent {
  final int page;
  final List<RecommendedAnimeMangaModel> recommendedList;
  GetMoreRecommendationMangaPagination({
    required this.page,
    required this.recommendedList,
  });
}

final class GetMoreTopManga extends MoreEvent {
  final int page;
  GetMoreTopManga({required this.page});
}

final class GetMoreTopMangaPagination extends MoreEvent {
  final int page;
  final List<TopAnimeMangaModel> animeModel;
  GetMoreTopMangaPagination({required this.animeModel, required this.page});
}
