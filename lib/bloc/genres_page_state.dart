part of 'genres_page_bloc.dart';

@immutable
sealed class GenresPageState {}

final class GenresPageInitial extends GenresPageState {}

final class GenresPageLoading extends GenresPageState {}

final class GenresPageFailed extends GenresPageState {
  final String error;
  GenresPageFailed({required this.error});
}

final class GenrePageSuccess extends GenresPageState {
  final List<GenrePageModel> genrePageModel;
  GenrePageSuccess({required this.genrePageModel});
}


