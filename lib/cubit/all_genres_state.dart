part of 'all_genres_cubit.dart';

@immutable
sealed class AllGenresState {}

final class AllGenresInitial extends AllGenresState {}

final class AllGenresPageLoading extends AllGenresState {}

final class AllGenresPageFailed extends AllGenresState {
  final String error;
  AllGenresPageFailed({required this.error});
}

final class AllGenresPageSuccess extends AllGenresState {
  final List<AnimeMangaGenreModel> animeMangaGenresModel;
  AllGenresPageSuccess({required this.animeMangaGenresModel});
}
