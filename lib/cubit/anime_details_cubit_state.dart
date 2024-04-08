part of 'anime_details_cubit.dart';

@immutable
sealed class AnimeDetailsCubitState {}

final class AnimeDetailsInitial extends AnimeDetailsCubitState {}

final class AnimeEpisodeDetailSuccess extends AnimeDetailsCubitState {
  final AnimeEpisodeDetailsModel animeEpisodeDetailsModel;
  AnimeEpisodeDetailSuccess({required this.animeEpisodeDetailsModel});
}

final class AnimeEpisodeCubitLoading extends AnimeDetailsCubitState {}

final class FailedAnimeCubit extends AnimeDetailsCubitState {
  final String error;
  FailedAnimeCubit({
    required this.error,
  });
}
