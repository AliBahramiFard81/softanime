part of 'genres_page_bloc.dart';

@immutable
sealed class GenresPageEvent {}

final class GetGenreTitle extends GenresPageEvent {
  final String type;
  final int id;
  GetGenreTitle({
    required this.id,
    required this.type,
  });
}

final class GetGenreTitlePagination extends GenresPageEvent {
  final int page;
  final List<GenrePageModel> list;
  final String type;
  final int id;
  GetGenreTitlePagination({
    required this.id,
    required this.list,
    required this.page,
    required this.type,
  });
}
