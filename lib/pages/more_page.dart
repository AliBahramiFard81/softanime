import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_character_actor_bloc.dart';
import 'package:main/bloc/anime_page_bloc.dart';
import 'package:main/bloc/manga_bloc.dart';
import 'package:main/bloc/more_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/common/navigation_bloc_data.dart';
import 'package:main/models/anime_popular_episodes_model.dart';
import 'package:main/models/recent_anime_episodes_model.dart';
import 'package:main/models/recommended_anime_manga_model.dart';
import 'package:main/models/top_anime_manga_model.dart';
import 'package:main/pages/anime_page.dart';
import 'package:main/pages/characters_page.dart';
import 'package:main/pages/home_page.dart';
import 'package:main/pages/manga_page.dart';
import 'package:main/widgets/custom_internet_image.dart';
import 'package:sizer/sizer.dart';

class MorePage extends StatefulWidget {
  final HomePageListType homePageListType;
  final MoreModelType moreModelType;
  final String title;
  const MorePage({
    super.key,
    required this.homePageListType,
    required this.moreModelType,
    required this.title,
  });

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  late ScrollController scrollController;
  bool isLoading = false;
  bool hasNextPage = true;
  int page = 1;
  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoreBloc, MoreState>(
      listener: (context, state) {
        if (state is MoreFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
        if (state is MoreSuccess) {
          page = page + 1;
          scrollController.addListener(() {
            if (scrollController.position.pixels ==
                    scrollController.position.maxScrollExtent &&
                !isLoading &&
                hasNextPage) {
              isLoading = true;
              if (widget.moreModelType == MoreModelType.recommended &&
                  widget.homePageListType == HomePageListType.anime) {
                BlocProvider.of<MoreBloc>(context)
                    .add(GetMoreRecommendationAnimePagination(
                  page: page,
                  recommendedList:
                      state.more as List<RecommendedAnimeMangaModel>,
                ));
              } else if (widget.moreModelType == MoreModelType.top &&
                  widget.homePageListType == HomePageListType.anime) {
                BlocProvider.of<MoreBloc>(context)
                    .add(GetMoreTopAnimePagination(
                  page: page,
                  animeModel: state.more as List<TopAnimeMangaModel>,
                ));
              } else if (widget.moreModelType == MoreModelType.recent &&
                  widget.homePageListType == HomePageListType.anime) {
                BlocProvider.of<MoreBloc>(context)
                    .add(GetMoreRecentAnimeEpisodePagination(
                  page: page,
                  recentModel: state.more as List<RecentAnimeEpisodesModel>,
                ));
              } else if (widget.moreModelType == MoreModelType.pop &&
                  widget.homePageListType == HomePageListType.anime) {
                BlocProvider.of<MoreBloc>(context)
                    .add(GetMorePopularAnimeEpisodePagination(
                  page: page,
                  popularModel: state.more as List<AnimePopularEpisodeModel>,
                ));
              } else if (widget.moreModelType == MoreModelType.recommended &&
                  widget.homePageListType == HomePageListType.manga) {
                BlocProvider.of<MoreBloc>(context)
                    .add(GetMoreRecommendationMangaPagination(
                  page: page,
                  recommendedList:
                      state.more as List<RecommendedAnimeMangaModel>,
                ));
              } else if (widget.moreModelType == MoreModelType.top &&
                  widget.homePageListType == HomePageListType.manga) {
                BlocProvider.of<MoreBloc>(context)
                    .add(GetMoreTopMangaPagination(
                  page: page,
                  animeModel: state.more as List<TopAnimeMangaModel>,
                ));
              }
            }
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: BlocBuilder<MoreBloc, MoreState>(
          builder: (context, state) {
            if (state is MoreSuccess) {
              return ListView(
                controller: scrollController,
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: (40.w / 30.h),
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.more.length,
                    itemBuilder: (context, index) {
                      hasNextPage = state.more.last.hasNextPage;
                      isLoading = false;
                      return SizedBox(
                        height: 35.h,
                        width: 40.w,
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
                            if (widget.homePageListType ==
                                HomePageListType.anime) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AnimePage(),
                                  ));
                              animePagesId.add(state.more[index].id);
                              context.read<AnimePageBloc>().add(GetAnime(
                                    id: state.more[index].id,
                                  ));
                            } else if (widget.homePageListType ==
                                HomePageListType.character) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CharacterPage(),
                                  ));
                              characterPageId.add(state.more[index].id);
                              BlocProvider.of<AnimeCharacterActorBloc>(context)
                                  .add(GetAnimeCharacter(
                                      id: state.more[index].id));
                            } else if (widget.homePageListType ==
                                HomePageListType.manga) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MangaPage(),
                                  ));
                              mangaPageId.add(state.more[index].id);
                              BlocProvider.of<MangaBloc>(context)
                                  .add(GetManga(id: state.more[index].id));
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 19.h,
                                width: 40.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CustomInternetImage(
                                    url: state.more[index].poster,
                                  ),
                                ),
                              ),
                              Text(
                                state.more[index].title,
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
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: state.more.isEmpty
                        ? 0.h
                        : state.more.last.hasNextPage
                            ? 5.h
                            : 0.h,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
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
    );
  }
}
