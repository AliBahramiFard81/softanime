part of 'manga_bloc.dart';

@immutable
sealed class MangaState {}

final class MangaInitial extends MangaState {}

final class MangaLoading extends MangaState {}

final class MangaSuccess extends MangaState {
  final MangaMainModel mangaMainModel;
  MangaSuccess({required this.mangaMainModel});
}

final class MangaFailed extends MangaState {
  final String error;
  final int id;
  MangaFailed({
    required this.error,
    required this.id,
  });
}
