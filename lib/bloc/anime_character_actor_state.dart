part of 'anime_character_actor_bloc.dart';

@immutable
sealed class AnimeCharacterActorState {}

final class AnimeCharacterActorInitial extends AnimeCharacterActorState {}

final class AnimeCharacterActorLoading extends AnimeCharacterActorState {}

final class AnimeCharacterActorFailed extends AnimeCharacterActorState {
  final String error;
  final int id;
  AnimeCharacterActorFailed({
    required this.id,
    required this.error,
  });
}

final class AnimeCharacterSuccess extends AnimeCharacterActorState {
  final AnimeCharactersMainModel animeCharactersMainModel;
  AnimeCharacterSuccess({required this.animeCharactersMainModel});
}