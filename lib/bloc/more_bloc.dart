import 'package:bloc/bloc.dart';
import 'package:main/models/anime_popular_episodes_model.dart';
import 'package:main/models/recent_anime_episodes_model.dart';
import 'package:main/models/recommended_anime_manga_model.dart';
import 'package:main/models/top_anime_manga_model.dart';
import 'package:main/services/more_service.dart';
import 'package:meta/meta.dart';

part 'more_event.dart';
part 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  MoreBloc() : super(MoreInitial()) {
    on<GetMoreRecommendationAnime>((event, emit) async {
      emit(MoreLoading());
      final model =
          await AnimeMangaMoreService().getRecommendedAnimeMore(event.page);
      if (model == null) {
        emit(MoreFailed(error: 'failed to fetch retrying...'));
      } else {
        emit(MoreSuccess(more: model));
      }
    });

    on<GetMoreRecommendationAnimePagination>((event, emit) async {
      final model =
          await AnimeMangaMoreService().getRecommendedAnimeMore(event.page);
      if (model == null) {
        emit(MoreFailed(error: 'failed to fetch retrying...'));
      } else {
        event.recommendedList.addAll(model);
        emit(MoreSuccess(more: event.recommendedList));
      }
    });

    on<GetMoreTopAnime>((event, emit) async {
      emit(MoreLoading());
      final model = await AnimeMangaMoreService().getTopAnimeMore(event.page);
      if (model == null) {
        emit(MoreFailed(error: 'failed to fetch retrying...'));
      } else {
        emit(MoreSuccess(more: model));
      }
    });

    on<GetMoreTopAnimePagination>((event, emit) async {
      final model = await AnimeMangaMoreService().getTopAnimeMore(event.page);
      if (model == null) {
        emit(MoreFailed(error: 'failed to fetch retrying...'));
      } else {
        event.animeModel.addAll(model);
        emit(MoreSuccess(more: event.animeModel));
      }
    });

    on<GetMoreRecentAnimeEpisode>((event, emit) async {
      emit(MoreLoading());
      final model =
          await AnimeMangaMoreService().getRecentAnimeMore(event.page);
      if (model == null) {
        emit(MoreFailed(error: 'failed to fetch retrying...'));
      } else {
        emit(MoreSuccess(more: model));
      }
    });

    on<GetMoreRecentAnimeEpisodePagination>((event, emit) async {
      final model =
          await AnimeMangaMoreService().getRecentAnimeMore(event.page);
      if (model == null) {
        emit(MoreFailed(error: 'failed to fetch retrying...'));
      } else {
        event.recentModel.addAll(model);
        emit(MoreSuccess(more: event.recentModel));
      }
    });

    on<GetMorePopularAnimeEpisode>((event, emit) async {
      emit(MoreLoading());
      final model =
          await AnimeMangaMoreService().getPopularAnimeMore(event.page);
      if (model == null) {
        emit(MoreFailed(error: 'failed to fetch retrying...'));
      } else {
        emit(MoreSuccess(more: model));
      }
    });

    on<GetMorePopularAnimeEpisodePagination>((event, emit) async {
      final model =
          await AnimeMangaMoreService().getPopularAnimeMore(event.page);
      if (model == null) {
        emit(MoreFailed(error: 'failed to fetch retrying...'));
      } else {
        event.popularModel.addAll(model);
        emit(MoreSuccess(more: event.popularModel));
      }
    });

    on<GetMoreRecommendationManga>((event, emit) async {
      emit(MoreLoading());
      final model =
          await AnimeMangaMoreService().getRecommendedMangaMore(event.page);
      if (model == null) {
        emit(MoreFailed(error: 'failed to fetch retrying...'));
      } else {
        emit(MoreSuccess(more: model));
      }
    });

    on<GetMoreRecommendationMangaPagination>((event, emit) async {
      final model =
          await AnimeMangaMoreService().getRecommendedMangaMore(event.page);
      if (model == null) {
        emit(MoreFailed(error: 'failed to fetch retrying...'));
      } else {
        event.recommendedList.addAll(model);
        emit(MoreSuccess(more: event.recommendedList));
      }
    });

    on<GetMoreTopManga>((event, emit) async {
      emit(MoreLoading());
      final model = await AnimeMangaMoreService().getTopMangaMore(event.page);
      if (model == null) {
        emit(MoreFailed(error: 'failed to fetch retrying...'));
      } else {
        emit(MoreSuccess(more: model));
      }
    });

    on<GetMoreTopMangaPagination>((event, emit) async {
      final model = await AnimeMangaMoreService().getTopMangaMore(event.page);
      if (model == null) {
        emit(MoreFailed(error: 'failed to fetch retrying...'));
      } else {
        event.animeModel.addAll(model);
        emit(MoreSuccess(more: event.animeModel));
      }
    });
  }
}
