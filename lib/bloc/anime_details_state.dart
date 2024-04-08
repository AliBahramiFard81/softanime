part of 'anime_details_bloc.dart';

@immutable
sealed class AnimeDetailsState {}

final class AnimeDetailsInitial extends AnimeDetailsState {}

final class AnimeEpisodesSuccess extends AnimeDetailsState {
  final List<AnimeEpisodeModel> animeEpisodeModel;
  AnimeEpisodesSuccess({required this.animeEpisodeModel});
}

final class Loading extends AnimeDetailsState {}

final class FailedAnimeDetails extends AnimeDetailsState {
  final String error;
  final int id;
  FailedAnimeDetails({
    required this.id,
    required this.error,
  });
}

final class AnimeImageGallerySuccess extends AnimeDetailsState {
  final List<AnimeImageGalleryModel> animeImageGalleryModel;
  AnimeImageGallerySuccess({required this.animeImageGalleryModel});
}

final class AnimeVideoGallerySuccess extends AnimeDetailsState {
  final List<AnimeVideoGalleryModel> animeVideoGalleryModel;
  AnimeVideoGallerySuccess({required this.animeVideoGalleryModel});
}

final class AnimeReviewsSuccess extends AnimeDetailsState {
  final List<AnimeReviewsModel> animeReviewsModel;
  AnimeReviewsSuccess({required this.animeReviewsModel});
}

final class AnimeCharacterPicturesSuccess extends AnimeDetailsState {
  final List<AnimeCharacterImageModel> animeCharacterImageModel;
  AnimeCharacterPicturesSuccess({required this.animeCharacterImageModel});
}
