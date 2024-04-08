// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:main/models/home_page_model.dart';
import 'package:main/services/home_page_service.dart';
import 'package:meta/meta.dart';
part 'anime_event.dart';
part 'anime_state.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  AnimeBloc() : super(AnimeInitial()) {
    on<GetHomePage>((event, emit) async {
      emit(AnimeHomeLoading());
      final homePageModel = await HomePageService().getHomePageContent();
      if (homePageModel == null) {
        emit(AnimeHomeFailed(error: 'failed to fetch retrying...'));
      } else {
        emit(AnimeHomeSuccess(homePageModel: homePageModel));
      }
    });
  }
}
