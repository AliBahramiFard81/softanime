import 'package:bloc/bloc.dart';
import 'package:main/models/anime_model.dart';
import 'package:main/services/anime_page_service.dart';
import 'package:meta/meta.dart';

part 'anime_page_event.dart';
part 'anime_page_state.dart';

class AnimePageBloc extends Bloc<AnimePageEvent, AnimePageState> {
  AnimePageBloc() : super(AnimePageInitial()) {
    on<GetAnime>((event, emit) async {
      emit(AnimePageLoading());
      final animeMainModel = await AnimePageService(id: event.id).getAnime();
      if (animeMainModel == null) {
        return emit(AnimePageFailed(
            error: 'failed to fetch retrying...', id: event.id));
      } else {
        return emit(AnimePageSuccess(animeMainModel: animeMainModel));
      }
    });
  }
}
