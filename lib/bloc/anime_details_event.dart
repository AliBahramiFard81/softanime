part of 'anime_details_bloc.dart';

@immutable
sealed class AnimeDetailsEvent {}

final class GetAnimeEpisodes extends AnimeDetailsEvent {
  final int id;
  final int page;
  GetAnimeEpisodes({required this.id, required this.page});
}

final class GetAnimeEpisodesPagination extends AnimeDetailsEvent {
  final List<AnimeEpisodeModel> animeEpisodeModel;
  final int id;
  final int page;
  GetAnimeEpisodesPagination({
    required this.animeEpisodeModel,
    required this.id,
    required this.page,
  });
}

final class GetAnimeImageGallery extends AnimeDetailsEvent {
  final int id;
  GetAnimeImageGallery({required this.id});
}

final class GetAnimeVideoGallery extends AnimeDetailsEvent {
  final int id;
  GetAnimeVideoGallery({required this.id});
}

final class GetAnimeReviews extends AnimeDetailsEvent {
  final int id;
  final int page;
  GetAnimeReviews({required this.id, required this.page});
}

final class GetAnimeReviewsPagination extends AnimeDetailsEvent {
  final List<AnimeReviewsModel> animeReviewsModel;
  final int id;
  final int page;
  GetAnimeReviewsPagination({
    required this.animeReviewsModel,
    required this.id,
    required this.page,
  });
}

final class GetAnimeCharacterImageGallery extends AnimeDetailsEvent {
  final int id;
  GetAnimeCharacterImageGallery({required this.id});
}

final class GetMangaPageImageGallery extends AnimeDetailsEvent {
  final int id;
  GetMangaPageImageGallery({required this.id});
}

final class GetMangaPageReviews extends AnimeDetailsEvent {
  final int id;
  GetMangaPageReviews({required this.id});
}
