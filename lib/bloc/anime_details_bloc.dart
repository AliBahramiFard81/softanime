import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:main/models/anime_characters_actors_model.dart';
import 'package:main/models/anime_model.dart';
import 'package:main/models/manga_model.dart';
import 'package:main/services/anime_characters_actors_service.dart';
import 'package:main/services/anime_page_service.dart';
import 'package:main/services/manga_service.dart';
import 'package:meta/meta.dart';
part 'anime_details_event.dart';
part 'anime_details_state.dart';

class AnimeDetailsBloc extends Bloc<AnimeDetailsEvent, AnimeDetailsState> {
  AnimeDetailsBloc() : super(AnimeDetailsInitial()) {
    on<GetAnimeEpisodes>((event, emit) async {
      emit(Loading());
      final animeEpisodeModel =
          await AnimePageService(id: event.id).getAnimeEpisodes(event.page);
      if (animeEpisodeModel == null) {
        emit(FailedAnimeDetails(
            error: 'failed to fetch retrying...', id: event.id));
      } else {
        emit(AnimeEpisodesSuccess(animeEpisodeModel: animeEpisodeModel));
      }
    });

    on<GetAnimeEpisodesPagination>((event, emit) async {
      final animeEpisodeModel =
          await AnimePageService(id: event.id).getAnimeEpisodes(event.page);
      if (animeEpisodeModel == null) {
        emit(FailedAnimeDetails(
            error: 'failed to fetch retrying...', id: event.id));
      } else {
        event.animeEpisodeModel.addAll(animeEpisodeModel);
        emit(AnimeEpisodesSuccess(animeEpisodeModel: event.animeEpisodeModel));
      }
    });

    on<GetAnimeImageGallery>((event, emit) async {
      emit(Loading());
      final imageGalleryModel =
          await AnimePageService(id: event.id).getAnimeImageGallery();
      if (imageGalleryModel == null) {
        emit(FailedAnimeDetails(
            error: 'failed to fetch retrying...', id: event.id));
      } else {
        emit(AnimeImageGallerySuccess(
            animeImageGalleryModel: imageGalleryModel));
      }
    });

    on<GetAnimeVideoGallery>((event, emit) async {
      emit(Loading());
      final videoGalleryModel =
          await AnimePageService(id: event.id).getAnimeVideoGallery();
      if (videoGalleryModel == null) {
        emit(FailedAnimeDetails(
            error: 'failed to fetch retrying...', id: event.id));
      } else {
        emit(AnimeVideoGallerySuccess(
            animeVideoGalleryModel: videoGalleryModel));
      }
    });

    on<GetAnimeReviews>((event, emit) async {
      emit(Loading());
      final reviewModel =
          await AnimePageService(id: event.id).getAnimeReviews(event.page);
      if (reviewModel == null) {
        emit(FailedAnimeDetails(
            error: 'failed to fetch retrying...', id: event.id));
      } else {
        emit(AnimeReviewsSuccess(animeReviewsModel: reviewModel));
      }
    });
    on<GetAnimeCharacterImageGallery>((event, emit) async {
      emit(Loading());
      final imageModel =
          await AnimeCharactersActorsService(id: event.id).getCharactersImage();
      if (imageModel == null) {
        emit(FailedAnimeDetails(
            error: 'failed to fetch retrying...', id: event.id));
      } else {
        emit(AnimeCharacterPicturesSuccess(
            animeCharacterImageModel: imageModel));
      }
    });

    on<GetMangaPageImageGallery>((event, emit) async {
      final imageModel =
          await MangaService(id: event.id).getMangaImageGallery();
      if (imageModel == null) {
        emit(FailedAnimeDetails(
            error: 'failed to fetch retrying...', id: event.id));
      } else {
        emit(MangaImageGallerySuccess(mangaImageGalleryModel: imageModel));
      }
    });

    on<GetMangaPageReviews>((event, emit) async {
      emit(Loading());
      final reviewsModel = await MangaService(id: event.id).getMangaReviews();
      if (reviewsModel == null) {
        emit(FailedAnimeDetails(
            error: 'failed to fetch retrying...', id: event.id));
      } else {
        emit(AnimeReviewsSuccess(animeReviewsModel: reviewsModel));
      }
    });
  }
}
