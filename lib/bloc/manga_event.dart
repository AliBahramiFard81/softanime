part of 'manga_bloc.dart';

@immutable
sealed class MangaEvent {}

final class GetManga extends MangaEvent {
  final int id;
  GetManga({required this.id});
}
