// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_bloc.dart';
import 'package:main/bloc/more_bloc.dart';
import 'package:main/cubit/carousel_cubit.dart';
import 'package:main/cubit/quotes_cubit.dart';
import 'package:main/pages/more_page.dart';
import 'package:main/widgets/home_page_appbar.dart';
import 'package:main/widgets/home_page_carousel.dart';
import 'package:main/widgets/home_page_genres.dart';
import 'package:main/widgets/home_page_item_list.dart';
import 'package:main/widgets/home_page_list_header.dart';
import 'package:main/widgets/home_page_quote_carousel.dart';
import 'package:main/widgets/home_page_review_carousel.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum HomePageListType { anime, manga, character, actor }

enum MoreModelType { recommended, top, recent, pop }

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return BlocListener<AnimeBloc, AnimeState>(
      listener: (context, state) {
        if (state is AnimeHomeFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
          context.read<AnimeBloc>().add(GetHomePage());
        }
      },
      child: Scaffold(
        appBar: const HomePageAppBar(),
        body: CustomMaterialIndicator(
          onRefresh: () async {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BlocListener<AnimeBloc, AnimeState>(
                  listener: (context, state) {
                    if (state is AnimeHomeSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                      final carouselCubit =
                          BlocProvider.of<CarouselCubit>(context);
                      carouselCubit.carouselProgressStart();
                    }
                  },
                  child: const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
            BlocProvider.of<AnimeBloc>(context).add(GetHomePage());
          },
          indicatorBuilder: (context, controller) {
            return const Icon(
              Icons.refresh_rounded,
              size: 30,
            );
          },
          child: BlocBuilder<AnimeBloc, AnimeState>(
            builder: (context, state) {
              if (state is AnimeHomeSuccess) {
                return ListView(
                  children: [
                    const HomePageCarousel(),
                    HomePageListHeader(
                      title: 'Recommended Anime',
                      buttonText: 'More',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MorePage(
                                homePageListType: HomePageListType.anime,
                                moreModelType: MoreModelType.recommended,
                                title: 'RECOMMENDED ANIME',
                              ),
                            ));
                        BlocProvider.of<MoreBloc>(context)
                            .add(GetMoreRecommendationAnime(page: 1));
                      },
                    ),
                    BlocBuilder<AnimeBloc, AnimeState>(
                      builder: (context, state) {
                        if (state is AnimeHomeSuccess) {
                          return HomePageItemList(
                            type: state.homePageModel.recommendedAnimeModel,
                            homePageListType: HomePageListType.anime,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    HomePageListHeader(
                      title: 'Top Anime',
                      buttonText: 'More',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MorePage(
                                homePageListType: HomePageListType.anime,
                                moreModelType: MoreModelType.top,
                                title: 'TOP ANIME',
                              ),
                            ));

                        BlocProvider.of<MoreBloc>(context)
                            .add(GetMoreTopAnime(page: 1));
                      },
                    ),
                    BlocBuilder<AnimeBloc, AnimeState>(
                      builder: (context, state) {
                        if (state is AnimeHomeSuccess) {
                          return HomePageItemList(
                            type: state.homePageModel.topAnimeModel,
                            homePageListType: HomePageListType.anime,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    HomePageListHeader(
                      title: 'Recent Anime Episode',
                      buttonText: 'More',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MorePage(
                                homePageListType: HomePageListType.anime,
                                moreModelType: MoreModelType.recent,
                                title: 'RECOMMENDED ANIME',
                              ),
                            ));

                        BlocProvider.of<MoreBloc>(context)
                            .add(GetMoreRecentAnimeEpisode(page: 1));
                      },
                    ),
                    BlocBuilder<AnimeBloc, AnimeState>(
                      builder: (context, state) {
                        if (state is AnimeHomeSuccess) {
                          return HomePageItemList(
                            type: state.homePageModel.recentAnimeEpisodeModel,
                            homePageListType: HomePageListType.anime,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    HomePageListHeader(
                      title: 'popular Anime Episode',
                      buttonText: 'More',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MorePage(
                                homePageListType: HomePageListType.anime,
                                moreModelType: MoreModelType.pop,
                                title: 'POPULAR ANIME',
                              ),
                            ));

                        BlocProvider.of<MoreBloc>(context)
                            .add(GetMorePopularAnimeEpisode(page: 1));
                      },
                    ),
                    BlocBuilder<AnimeBloc, AnimeState>(
                      builder: (context, state) {
                        if (state is AnimeHomeSuccess) {
                          return HomePageItemList(
                            type: state.homePageModel.popularAnimeEpisodeModel,
                            homePageListType: HomePageListType.anime,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    HomePageListHeader(
                      title: 'Recommended Manga',
                      buttonText: 'More',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MorePage(
                                homePageListType: HomePageListType.manga,
                                moreModelType: MoreModelType.recommended,
                                title: 'RECOMMENDED MANGA',
                              ),
                            ));

                        BlocProvider.of<MoreBloc>(context)
                            .add(GetMoreRecommendationManga(page: 1));
                      },
                    ),
                    BlocBuilder<AnimeBloc, AnimeState>(
                      builder: (context, state) {
                        if (state is AnimeHomeSuccess) {
                          return HomePageItemList(
                            type: state.homePageModel.recommendedMangaModel,
                            homePageListType: HomePageListType.manga,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    HomePageListHeader(
                      title: 'Top Manga',
                      buttonText: 'More',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MorePage(
                                homePageListType: HomePageListType.manga,
                                moreModelType: MoreModelType.top,
                                title: 'TOP MANGA',
                              ),
                            ));

                        BlocProvider.of<MoreBloc>(context)
                            .add(GetMoreTopManga(page: 1));
                      },
                    ),
                    BlocBuilder<AnimeBloc, AnimeState>(
                      builder: (context, state) {
                        if (state is AnimeHomeSuccess) {
                          return HomePageItemList(
                            type: state.homePageModel.topMangaModel,
                            homePageListType: HomePageListType.manga,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    const HomePageGenre(),
                    HomePageListHeader(
                      title: 'Top Characters',
                      buttonText: 'More',
                      onPressed: () {},
                    ),
                    BlocBuilder<AnimeBloc, AnimeState>(
                      builder: (context, state) {
                        if (state is AnimeHomeSuccess) {
                          return HomePageItemList(
                            type: state.homePageModel.topCharacterModel,
                            homePageListType: HomePageListType.character,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    HomePageListHeader(
                      title: 'Top Actors',
                      buttonText: 'More',
                      onPressed: () {},
                    ),
                    BlocBuilder<AnimeBloc, AnimeState>(
                      builder: (context, state) {
                        if (state is AnimeHomeSuccess) {
                          return HomePageItemList(
                            type: state.homePageModel.topActorModel,
                            homePageListType: HomePageListType.actor,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    HomePageListHeader(
                      title: 'Top Reviews(Spoiler)',
                      buttonText: 'More',
                      onPressed: () {},
                    ),
                    const HomePageReviewCarousel(),
                    HomePageListHeader(
                      title: 'Anime Quotes',
                      buttonText: 'Refresh',
                      onPressed: () {
                        final quotesCubit =
                            BlocProvider.of<QuotesCubit>(context);
                        quotesCubit.quotesRefresh();
                      },
                    ),
                    const HomePageQuoteCarousel(),
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
