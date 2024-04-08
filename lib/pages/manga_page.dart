import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:main/bloc/anime_character_actor_bloc.dart';
import 'package:main/bloc/manga_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/common/navigation_bloc_data.dart';
import 'package:main/pages/characters_page.dart';
import 'package:main/widgets/anime_manga_page_header.dart';
import 'package:main/widgets/anime_manga_page_info.dart';
import 'package:main/widgets/anime_manga_page_poster.dart';
import 'package:main/widgets/anime_manga_page_rating.dart';
import 'package:main/widgets/anime_manga_page_title_header.dart';
import 'package:main/widgets/custom_internet_image.dart';
import 'package:sizer/sizer.dart';

class MangaPage extends StatelessWidget {
  const MangaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MangaBloc, MangaState>(
          listener: (context, state) {
            if (state is MangaFailed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
        ),
      ],
      child: PopScope(
        onPopInvoked: (didPop) {
          if (didPop) {
            mangaPageId.removeLast();
            if (mangaPageId.isNotEmpty) {
              BlocProvider.of<MangaBloc>(context)
                  .add(GetManga(id: mangaPageId.last));
            }
          }
        },
        child: Scaffold(
          body: BlocBuilder<MangaBloc, MangaState>(
            builder: (context, state) {
              if (state is MangaSuccess) {
                return ListView(
                  children: [
                    Stack(
                      children: [
                        AnimeMangaPagePoster(
                            poster: state.mangaMainModel.mangaModel.poster),
                        AnimeMangaPageHeader(
                            title: state.mangaMainModel.mangaModel.title),
                      ],
                    ),
                    AnimeMangaPageRating(
                      score: state.mangaMainModel.mangaModel.score.toString(),
                      scoreBy:
                          state.mangaMainModel.mangaModel.scoredBy.toString(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
                      width: 100.w,
                      child: Text(
                        state.mangaMainModel.mangaModel.title,
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
                        itemCount: state.mangaMainModel.mangaModel.genre.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 2.w),
                            child: ActionChip(
                              label: Text(state
                                  .mangaMainModel.mangaModel.genre[index].name),
                              onPressed: () {},
                            ),
                          );
                        },
                      ),
                    ),
                    AnimeMangaPageInfo(
                      icon: Icons.info_outline_rounded,
                      title: 'status',
                      text: state.mangaMainModel.mangaModel.status,
                    ),
                    AnimeMangaPageInfo(
                      icon: Icons.calendar_month_rounded,
                      title: 'date',
                      text: DateFormat.yMMMMEEEEd().format(
                          DateTime.parse(state.mangaMainModel.mangaModel.date)),
                    ),
                    AnimeMangaPageInfo(
                      icon: Icons.type_specimen_rounded,
                      title: 'type',
                      text: state.mangaMainModel.mangaModel.type,
                    ),
                    AnimeMangaPageInfo(
                      icon: Icons.category_rounded,
                      title: 'demographic',
                      text: state.mangaMainModel.mangaModel.demographic,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
                      child: Text(
                        state.mangaMainModel.mangaModel.synopsis,
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
                        itemCount: state.mangaMainModel.charactersModel.length,
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
                                characterPageId.add(state
                                    .mangaMainModel.charactersModel[index].id);
                                BlocProvider.of<AnimeCharacterActorBloc>(
                                        context)
                                    .add(
                                  GetAnimeCharacter(
                                      id: state.mangaMainModel
                                          .charactersModel[index].id),
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
                                        url: state.mangaMainModel
                                            .charactersModel[index].image,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.mangaMainModel.charactersModel[index]
                                        .name,
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
                        itemCount:
                            state.mangaMainModel.mangaRecommendations.length,
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
                                      builder: (context) => const MangaPage(),
                                    ));
                                mangaPageId.add(state.mangaMainModel
                                    .mangaRecommendations[index].id);
                                BlocProvider.of<MangaBloc>(context).add(
                                    GetManga(
                                        id: state.mangaMainModel
                                            .mangaRecommendations[index].id));
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
                                        url: state.mangaMainModel
                                            .mangaRecommendations[index].poster,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.mangaMainModel
                                        .mangaRecommendations[index].title,
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
