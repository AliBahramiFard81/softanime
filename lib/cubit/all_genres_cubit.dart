import 'package:bloc/bloc.dart';
import 'package:main/models/anime_manga_genre_model.dart';
import 'package:main/services/genres_service.dart';
import 'package:meta/meta.dart';

part 'all_genres_state.dart';

class AllGenresCubit extends Cubit<AllGenresState> {
  AllGenresCubit() : super(AllGenresInitial());

  void getAllGenres(String type) async {
    emit(AllGenresPageLoading());
    final genres = await GenresService().getAllGenres(type);
    if (genres == null) {
      return emit(AllGenresPageFailed(error: 'Something went wrong...'));
    } else {
      return emit(AllGenresPageSuccess(animeMangaGenresModel: genres));
    }
  }
}
