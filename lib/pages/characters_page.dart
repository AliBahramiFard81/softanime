import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_character_actor_bloc.dart';
import 'package:main/bloc/anime_details_bloc.dart';
import 'package:main/bloc/anime_page_bloc.dart';
import 'package:main/bloc/manga_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/common/navigation_bloc_data.dart';
import 'package:main/pages/anime_page.dart';
import 'package:main/pages/manga_page.dart';
import 'package:main/widgets/anime_manga_page_detail_button.dart';
import 'package:main/widgets/anime_manga_page_header.dart';
import 'package:main/widgets/anime_manga_page_info.dart';
import 'package:main/widgets/anime_manga_page_poster.dart';
import 'package:main/widgets/anime_manga_page_title_header.dart';
import 'package:main/widgets/anime_page_details.dart';
import 'package:main/widgets/custom_internet_image.dart';
import 'package:sizer/sizer.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AnimeCharacterActorBloc, AnimeCharacterActorState>(
          listener: (context, state) {},
        ),
      ],
      child: PopScope(
        onPopInvoked: (didPop) {
          if (didPop) {
            characterPageId.removeLast();
            if (characterPageId.isNotEmpty) {
              BlocProvider.of<AnimeCharacterActorBloc>(context).add(
                GetAnimeCharacter(id: characterPageId.last),
              );
            }
          }
        },
        child: Scaffold(
          body: BlocBuilder<AnimeCharacterActorBloc, AnimeCharacterActorState>(
            builder: (context, state) {
              if (state is AnimeCharacterSuccess) {
                return ListView(
                  children: [
                    Stack(
                      children: [
                        AnimeMangaPagePoster(
                            poster: state
                                .animeCharactersMainModel.animeCharacter.image),
                        AnimeMangaPageHeader(
                            title: state
                                .animeCharactersMainModel.animeCharacter.name),
                      ],
                    ),
                    AnimeMangaPageInfo(
                      icon: Icons.account_circle,
                      title: 'name',
                      text: state.animeCharactersMainModel.animeCharacter.name,
                    ),
                    AnimeMangaPageInfo(
                      icon: Icons.translate_rounded,
                      title: 'jap name',
                      text:
                          state.animeCharactersMainModel.animeCharacter.japName,
                    ),
                    const AnimeMangaPageInfo(
                      icon: Icons.info_outline_rounded,
                      title: 'about',
                      text: '',
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
                      child: Text(
                        state.animeCharactersMainModel.animeCharacter.about,
                        textAlign: TextAlign.justify,
                        style: textStyle3ColorHeight,
                      ),
                    ),
                    const AnimeMangaPageHeaterTitle(title: 'Anime'),
                    Container(
                      margin: EdgeInsets.only(top: 4.w),
                      height: 20.h,
                      width: 100.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.animeCharactersMainModel
                                    .animeCharacterAnime.length >
                                25
                            ? 25
                            : state.animeCharactersMainModel.animeCharacterAnime
                                .length,
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
                                animePagesId.add(state.animeCharactersMainModel
                                    .animeCharacterAnime[index].id);
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
                                        url: state.animeCharactersMainModel
                                            .animeCharacterAnime[index].poster,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.animeCharactersMainModel
                                        .animeCharacterAnime[index].title,
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
                    const AnimeMangaPageHeaterTitle(title: 'Manga'),
                    Container(
                      margin: EdgeInsets.only(top: 4.w),
                      height: 20.h,
                      width: 100.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.animeCharactersMainModel
                                    .animeCharacterManga.length >
                                25
                            ? 25
                            : state.animeCharactersMainModel.animeCharacterManga
                                .length,
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
                                mangaPageId.add(state.animeCharactersMainModel
                                    .animeCharacterManga[index].id);
                                BlocProvider.of<MangaBloc>(context).add(
                                    GetManga(
                                        id: state.animeCharactersMainModel
                                            .animeCharacterManga[index].id));
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
                                        url: state.animeCharactersMainModel
                                            .animeCharacterManga[index].poster,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.animeCharactersMainModel
                                        .animeCharacterManga[index].title,
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
                    const AnimeMangaPageHeaterTitle(title: 'Voice Actor'),
                    Container(
                      margin: EdgeInsets.only(top: 4.w),
                      height: 20.h,
                      width: 100.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.animeCharactersMainModel
                                    .animeCharacterActor.length >
                                25
                            ? 25
                            : state.animeCharactersMainModel.animeCharacterActor
                                .length,
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
                                        url: state.animeCharactersMainModel
                                            .animeCharacterActor[index].poster,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.animeCharactersMainModel
                                        .animeCharacterActor[index].title,
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
                      title: 'images gallery',
                      onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) => const ImageGallery(),
                        );
                        BlocProvider.of<AnimeDetailsBloc>(context).add(
                          GetAnimeCharacterImageGallery(
                              id: state
                                  .animeCharactersMainModel.animeCharacter.id),
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
