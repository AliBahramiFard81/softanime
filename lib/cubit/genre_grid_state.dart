part of 'genre_grid_cubit.dart';

@immutable
sealed class GenreGridState {}

final class GenreGridInitial extends GenreGridState {}

final class GenreChanged extends GenreGridState {
  final Genre genre;
  GenreChanged({required this.genre});
}
