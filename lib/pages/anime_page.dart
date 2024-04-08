import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_character_actor_bloc.dart';
import 'package:main/bloc/anime_details_bloc.dart';
import 'package:main/bloc/anime_page_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/common/navigation_bloc_data.dart';
import 'package:main/pages/characters_page.dart';
import 'package:main/widgets/anime_manga_page_detail_button.dart';
import 'package:main/widgets/anime_manga_page_header.dart';
import 'package:main/widgets/anime_manga_page_info.dart';
import 'package:main/widgets/anime_manga_page_poster.dart';
import 'package:main/widgets/anime_manga_page_rating.dart';
import 'package:main/widgets/anime_manga_page_title_header.dart';
import 'package:main/widgets/anime_page_details.dart';
import 'package:main/widgets/custom_internet_image.dart';
import 'package:sizer/sizer.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MultiBlocListener(
      listeners: [
        BlocListener<AnimePageBloc, AnimePageState>(
          listener: (context, state) {
            if (state is AnimePageFailed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
        ),
      ],
      child: PopScope(
        onPopInvoked: (didPop) {
          if (didPop) {
            animePagesId.removeLast();
            if (animePagesId.isNotEmpty) {
              context.read<AnimePageBloc>().add(GetAnime(
                    id: animePagesId.last,
                  ));
            }
          }
        },
        child: Scaffold(
          body: BlocBuilder<AnimePageBloc, AnimePageState>(
            builder: (context, state) {
              if (state is AnimePageSuccess) {
                return ListView(
                  children: [
                    Stack(
                      children: [
                        AnimeMangaPagePoster(
                            poster: state.animeMainModel.animeModel.poster),
                        AnimeMangaPageHeader(
                            title: state.animeMainModel.animeModel.title),
                      ],
                    ),
                    AnimeMangaPageRating(
                      score: state.animeMainModel.animeModel.score.toString(),
                      scoreBy:
                          state.animeMainModel.animeModel.popularity.toString(),
                    ),
                    Center(
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
                        child: Text(
                          '${state.animeMainModel.animeModel.year} - ${state.animeMainModel.animeModel.type} - ${state.animeMainModel.animeModel.episodes} EP - ${state.animeMainModel.animeModel.duration.toUpperCase()}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
                      width: 100.w,
                      child: Text(
                        state.animeMainModel.animeModel.title,
                        maxLines: 1,
                        softWrap: false,
                        style: textStyle8,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
                      height: 5.h,
                      width: 100.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            state.animeMainModel.animeModel.genres.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 2.w),
                            child: ActionChip(
                              label: Text(state.animeMainModel.animeModel
                                  .genres[index].name),
                              onPressed: () {},
                            ),
                          );
                        },
                      ),
                    ),
                    AnimeMangaPageInfo(
                      icon: Icons.info_outline_rounded,
                      title: 'status',
                      text: state.animeMainModel.animeModel.status,
                    ),
                    AnimeMangaPageInfo(
                      icon: Icons.source_rounded,
                      title: 'source',
                      text: state.animeMainModel.animeModel.source,
                    ),
                    AnimeMangaPageInfo(
                      icon: Icons.child_care_rounded,
                      title: 'age rating',
                      text: state.animeMainModel.animeModel.rating,
                    ),
                    AnimeMangaPageInfo(
                      icon: Icons.category_rounded,
                      title: 'demographic',
                      text: state.animeMainModel.animeModel.demographic,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
                      child: Text(
                        state.animeMainModel.animeModel.synopsis,
                        textAlign: TextAlign.justify,
                        style: textStyle3ColorHeight,
                      ),
                    ),
                    const AnimeMangaPageHeaterTitle(title: 'characters'),
                    Container(
                      margin: EdgeInsets.only(top: 4.w),
                      height: 20.h,
                      width: 100.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.animeMainModel.characters.length > 25
                            ? 25
                            : state.animeMainModel.characters.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 20.h,
                            width: 30.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: EdgeInsets.all(2.w),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CharacterPage(),
                                    ));
                                characterPageId.add(
                                    state.animeMainModel.characters[index].id);
                                BlocProvider.of<AnimeCharacterActorBloc>(
                                        context)
                                    .add(
                                  GetAnimeCharacter(
                                      id: state
                                          .animeMainModel.characters[index].id),
                                );
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 16.h,
                                    width: 30.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CustomInternetImage(
                                        url: state.animeMainModel
                                            .characters[index].image,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.animeMainModel.characters[index].name,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: textStyle2Color,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const AnimeMangaPageHeaterTitle(title: 'voice actors'),
                    Container(
                      margin: EdgeInsets.only(top: 4.w),
                      height: 20.h,
                      width: 100.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.animeMainModel.characters.length > 25
                            ? 25
                            : state.animeMainModel.characters.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 20.h,
                            width: 30.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: EdgeInsets.all(2.w),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 16.h,
                                    width: 30.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CustomInternetImage(
                                        url: state.animeMainModel
                                            .characters[index].actorImage,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.animeMainModel.characters[index]
                                        .voiceActor,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: textStyle2Color,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const AnimeMangaPageHeaterTitle(title: 'recommendations'),
                    Container(
                      margin: EdgeInsets.only(top: 4.w),
                      height: 20.h,
                      width: 100.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.animeMainModel.characters.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 20.h,
                            width: 30.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: EdgeInsets.all(2.w),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AnimePage(),
                                    ));
                                animePagesId.add(state
                                    .animeMainModel.recommendations[index].id);
                                context.read<AnimePageBloc>().add(GetAnime(
                                      id: animePagesId.last,
                                    ));
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 16.h,
                                    width: 30.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CustomInternetImage(
                                        url: state.animeMainModel
                                            .recommendations[index].poster,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.animeMainModel.recommendations[index]
                                        .title,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: textStyle2Color,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    AnimeMangaPageDetailButton(
                      title: 'episodes',
                      onPressed: () {
                        showFlexibleBottomSheet(
                          context: context,
                          minHeight: 0,
                          initHeight: 0.5,
                          maxHeight: 1,
                          anchors: [0, 0.5, 1],
                          bottomSheetBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          builder:
                              (context, scrollController, bottomSheetOffset) {
                            return Episodes(
                              id: state.animeMainModel.animeModel.id,
                              scrollController: scrollController,
                            );
                          },
                        );
                        context.read<AnimeDetailsBloc>().add(
                              GetAnimeEpisodes(
                                id: state.animeMainModel.animeModel.id,
                                page: 1,
                              ),
                            );
                      },
                    ),
                    AnimeMangaPageDetailButton(
                      title: 'images gallery',
                      onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) => const ImageGallery(),
                        );
                        BlocProvider.of<AnimeDetailsBloc>(context).add(
                          GetAnimeImageGallery(
                              id: state.animeMainModel.animeModel.id),
                        );
                      },
                    ),
                    AnimeMangaPageDetailButton(
                      title: 'videos gallery',
                      onPressed: () {
                        showFlexibleBottomSheet(
                          context: context,
                          minHeight: 0,
                          initHeight: 0.5,
                          maxHeight: 1,
                          anchors: [0, 0.5, 1],
                          bottomSheetBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          builder:
                              (context, scrollController, bottomSheetOffset) {
                            return VideoGallery(
                              scrollController: scrollController,
                            );
                          },
                        );
                        BlocProvider.of<AnimeDetailsBloc>(context).add(
                          GetAnimeVideoGallery(
                              id: state.animeMainModel.animeModel.id),
                        );
                      },
                    ),
                    AnimeMangaPageDetailButton(
                      title: 'users reviews',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Reviews(
                                poster: state.animeMainModel.animeModel.poster,
                                title: state.animeMainModel.animeModel.title,
                                id: state.animeMainModel.animeModel.id,
                              ),
                            ));
                        BlocProvider.of<AnimeDetailsBloc>(context).add(
                          GetAnimeReviews(
                            id: state.animeMainModel.animeModel.id,
                            page: 1,
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
