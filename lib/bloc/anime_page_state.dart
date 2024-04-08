part of 'anime_page_bloc.dart';

@immutable
sealed class AnimePageState {}

final class AnimePageInitial extends AnimePageState {}

final class AnimePageLoading extends AnimePageState {}

final class AnimePageFailed extends AnimePageState {
  final String error;
  final int id;
  AnimePageFailed({
    required this.error,
    required this.id,
  });
}

final class AnimePageSuccess extends AnimePageState {
  final AnimeMainModel animeMainModel;
  AnimePageSuccess({required this.animeMainModel});
}
