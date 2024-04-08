import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/cubit/genre_grid_cubit.dart';
import 'package:main/pages/home_page.dart';
import 'package:sizer/sizer.dart';

class HomePageGenre extends StatelessWidget {
  const HomePageGenre({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreGridCubit, GenreGridState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                spreadRadius: 5,
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.w),
          height: 40.h,
          child: Column(
            children: [
              Text(
                'Genres',
                maxLines: 1,
                softWrap: false,
                style: textStyle1,
              ),
              SizedBox(height: 1.h),
              SizedBox(
                width: 100.w,
                child: SegmentedButton<Genre>(
                  segments: [
                    ButtonSegment(
                      value: Genre.anime,
                      label: Text(
                        'Anime',
                        style: textStyle3,
                      ),
                      icon: const Icon(Icons.movie_creation_rounded),
                    ),
                    ButtonSegment(
                      value: Genre.manga,
                      label: Text(
                        'Manga',
                        style: textStyle3,
                      ),
                      icon: const Icon(Icons.book),
                    ),
                  ],
                  showSelectedIcon: false,
                  selected:
                      state is GenreChanged ? {state.genre} : {Genre.anime},
                  onSelectionChanged: (p0) {
                    final genreCubit = BlocProvider.of<GenreGridCubit>(context);
                    genreCubit.genreChanged(p0.first);
                  },
                ),
              ),
              SizedBox(height: 1.h),
              Expanded(
                child: IndexedStack(
                  index: state is GenreChanged && state.genre == Genre.anime
                      ? 0
                      : state is GenreChanged && state.genre == Genre.manga
                          ? 1
                          : 0,
                  children: [
                    BlocBuilder<AnimeBloc, AnimeState>(
                      builder: (context, state) {
                        if (state is AnimeHomeSuccess) {
                          return GridView.count(
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            crossAxisCount: 4,
                            childAspectRatio: 2.5,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(
                              20,
                              (index) => TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(0),
                                ),
                                onPressed: () {},
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      state.homePageModel.animeGenreModel[index]
                                          .name,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: textStyle3,
                                    ),
                                    Text(
                                      state.homePageModel.animeGenreModel[index]
                                          .count
                                          .toString(),
                                      style: textStyle2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    BlocBuilder<AnimeBloc, AnimeState>(
                      builder: (context, state) {
                        if (state is AnimeHomeSuccess) {
                          return GridView.count(
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            crossAxisCount: 4,
                            childAspectRatio: 2.5,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(
                              20,
                              (index) => TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(0),
                                ),
                                onPressed: () {},
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      state.homePageModel.mangaGenreModel[index]
                                          .name,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: textStyle3,
                                    ),
                                    Text(
                                      state.homePageModel.mangaGenreModel[index]
                                          .count
                                          .toString(),
                                      style: textStyle2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100.w,
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'More',
                        style: textStyle2,
                      ),
                      SizedBox(width: 1.w),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 15.sp,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
