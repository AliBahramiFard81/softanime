import 'package:bloc/bloc.dart';
import 'package:main/widgets/home_page_genres.dart';

import 'package:meta/meta.dart';

part 'genre_grid_state.dart';

class GenreGridCubit extends Cubit<GenreGridState> {
  GenreGridCubit() : super(GenreGridInitial());

  void genreChanged(Genre genre) {
    return emit(GenreChanged(genre: genre));
  }
}
