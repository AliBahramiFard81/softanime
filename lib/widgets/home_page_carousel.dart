import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/simple_icons.dart';
import 'package:main/bloc/anime_bloc.dart';
import 'package:main/bloc/anime_page_bloc.dart';
import 'package:main/cubit/carousel_cubit.dart';
import 'package:main/pages/anime_page.dart';
import 'package:main/widgets/custom_internet_image.dart';
import 'package:main/widgets/home_page_carousel_details.dart';
import 'package:sizer/sizer.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';

class HomePageCarousel extends StatelessWidget {
  const HomePageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final carouselCubit = BlocProvider.of<CarouselCubit>(context);
    return BlocBuilder<AnimeBloc, AnimeState>(
      builder: (context, state) {
        if (state is AnimeHomeSuccess) {
          return SizedBox(
            height: 25.h,
            child: CarouselSlider.builder(
              itemCount: 3,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  margin: EdgeInsets.all(2.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AnimePage(),
                            ));
                        context.read<AnimePageBloc>().add(GetAnime(
                              id: state
                                  .homePageModel.randomAnimeModel[index].id,
                            ));
                      },
                      child: Stack(
                        children: [
                          ShaderMask(
                            blendMode: BlendMode.modulate,
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: CustomInternetImage(
                                    url: state.homePageModel
                                        .randomAnimeModel[index].poster,
                                  ),
                                ),
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color.fromARGB(255, 65, 64, 64),
                                  Color.fromRGBO(255, 255, 255, 0.9)
                                ],
                              ).createShader(
                                Rect.fromLTRB(
                                  0,
                                  0,
                                  bounds.width,
                                  bounds.height,
                                ),
                              );
                            },
                          ),
                          Row(
                            children: [
                              Container(
                                width: 30.w,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          const Color.fromARGB(255, 48, 48, 48)
                                              .withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                    )
                                  ],
                                ),
                                margin: EdgeInsets.all(2.5.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                    height: 25.h,
                                    child: CustomInternetImage(
                                      url: state.homePageModel
                                          .randomAnimeModel[index].poster,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 2.5.w,
                                    vertical: 4.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      HomePageCarouselDetails(
                                        text: state.homePageModel
                                            .randomAnimeModel[index].title,
                                        icon: Mdi.format_list_bulleted_type,
                                      ),
                                      HomePageCarouselDetails(
                                        text: state.homePageModel
                                            .randomAnimeModel[index].type,
                                        icon: Mdi.format_list_bulleted_type,
                                      ),
                                      HomePageCarouselDetails(
                                        text: state.homePageModel
                                            .randomAnimeModel[index].status,
                                        icon: Fa6Solid.satellite_dish,
                                      ),
                                      HomePageCarouselDetails(
                                        text: state.homePageModel
                                            .randomAnimeModel[index].score
                                            .toString(),
                                        icon: SimpleIcons.myanimelist,
                                      ),
                                      HomePageCarouselDetails(
                                        text: state.homePageModel
                                            .randomAnimeModel[index].popularity
                                            .toString(),
                                        icon: FluentMdl2.people,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          BlocBuilder<CarouselCubit, CarouselState>(
                            builder: (context, state) {
                              return Container(
                                alignment: Alignment.bottomCenter,
                                child: LinearProgressIndicator(
                                  minHeight: 1.h,
                                  value: state is CarouselProgressValue
                                      ? state.value
                                      : 0,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayCurve: Curves.easeInOutSine,
                onPageChanged: ((index, reason) async {
                  carouselCubit.carouselProgressReset();
                  await Future.delayed(const Duration(milliseconds: 1));
                  carouselCubit.carouselProgressStart();
                }),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
