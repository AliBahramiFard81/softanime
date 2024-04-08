part of 'anime_character_actor_bloc.dart';

@immutable
sealed class AnimeCharacterActorEvent {}

final class GetAnimeCharacter extends AnimeCharacterActorEvent {
  final int id;
  GetAnimeCharacter({required this.id});
}
