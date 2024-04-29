import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:main/models/genre_page_model.dart';
import 'package:main/services/genres_service.dart';
import 'package:meta/meta.dart';

part 'genres_page_event.dart';
part 'genres_page_state.dart';

class GenresPageBloc extends Bloc<GenresPageEvent, GenresPageState> {
  GenresPageBloc() : super(GenresPageInitial()) {
    on<GetGenreTitle>((event, emit) async {
      emit(GenresPageLoading());
      final titles =
          await GenresService().getGenreTitles(event.id, event.type, 1);
      if (titles == null) {
        emit(GenresPageFailed(error: 'Something went wrong...'));
      } else {
        emit(GenrePageSuccess(genrePageModel: titles));
      }
    });
    on<GetGenreTitlePagination>((event, emit) async {
      final nextPage = await GenresService()
          .getGenreTitles(event.id, event.type, event.page);
      if (nextPage == null) {
        emit(GenresPageFailed(error: 'Something went wrong...'));
      } else {
        event.list.addAll(nextPage);
        emit(GenrePageSuccess(genrePageModel: event.list));
      }
    });
  }
}
