import 'package:bloc/bloc.dart';
import 'package:main/models/anime_model.dart';
import 'package:main/services/anime_page_service.dart';
import 'package:meta/meta.dart';

part 'anime_details_cubit_state.dart';

class AnimeDetailsCubit extends Cubit<AnimeDetailsCubitState> {
  AnimeDetailsCubit() : super(AnimeDetailsInitial());

  void getAnimeEpisodeDetails(int id, int ep) async {
    emit(AnimeEpisodeCubitLoading());
    final animeEpisodeDetailModel =
        await AnimePageService(id: id).getAnimeEpisodeDetails(ep);
    if (animeEpisodeDetailModel == null) {
      return emit(FailedAnimeCubit(error: 'Failed...'));
    } else {
      return emit(
        AnimeEpisodeDetailSuccess(
            animeEpisodeDetailsModel: animeEpisodeDetailModel),
      );
    }
  }
}
