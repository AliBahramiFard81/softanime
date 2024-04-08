part of 'anime_page_bloc.dart';

@immutable
sealed class AnimePageEvent {}

final class GetAnime extends AnimePageEvent {
  final int id;
  GetAnime({required this.id});
}
