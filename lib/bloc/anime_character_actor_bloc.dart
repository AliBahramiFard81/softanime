import 'package:bloc/bloc.dart';
import 'package:main/models/anime_characters_actors_model.dart';
import 'package:main/services/anime_characters_actors_service.dart';
import 'package:meta/meta.dart';

part 'anime_character_actor_event.dart';
part 'anime_character_actor_state.dart';

class AnimeCharacterActorBloc
    extends Bloc<AnimeCharacterActorEvent, AnimeCharacterActorState> {
  AnimeCharacterActorBloc() : super(AnimeCharacterActorInitial()) {
    on<GetAnimeCharacter>((event, emit) async {
      emit(AnimeCharacterActorLoading());
      final animeCharacterModel =
          await AnimeCharactersActorsService(id: event.id).getAnimeCharacter();
      if (animeCharacterModel == null) {
        emit(AnimeCharacterActorFailed(
          id: event.id,
          error: 'failed to fetch retrying...',
        ));
      } else {
        emit(AnimeCharacterSuccess(
            animeCharactersMainModel: animeCharacterModel));
      }
    });
  }
}
