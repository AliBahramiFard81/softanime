part of 'anime_bloc.dart';

@immutable
sealed class AnimeState {}

final class AnimeInitial extends AnimeState {}

final class AnimeHomeLoading extends AnimeState {}

final class AnimeHomeSuccess extends AnimeState {
  final HomePageModel homePageModel;
  AnimeHomeSuccess({required this.homePageModel});
}

final class AnimeHomeFailed extends AnimeState {
  final String error;
  AnimeHomeFailed({required this.error});
}
