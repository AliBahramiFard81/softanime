import 'package:bloc/bloc.dart';
import 'package:main/models/manga_model.dart';
import 'package:main/services/manga_service.dart';
import 'package:meta/meta.dart';

part 'manga_event.dart';
part 'manga_state.dart';

class MangaBloc extends Bloc<MangaEvent, MangaState> {
  MangaBloc() : super(MangaInitial()) {
    on<GetManga>((event, emit) async {
      emit(MangaLoading());
      final mangaModel = await MangaService(id: event.id).getManga();
      if (mangaModel == null) {
        emit(MangaFailed(id: event.id, error: 'failed to fetch retrying...'));
      } else {
        emit(MangaSuccess(mangaMainModel: mangaModel));
      }
    });
  }
}
