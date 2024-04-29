import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:intl/intl.dart';
import 'package:main/bloc/anime_details_bloc.dart';
import 'package:main/common/colors.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/cubit/anime_details_cubit.dart';
import 'package:main/widgets/custom_internet_image.dart';
import 'package:sizer/sizer.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Episodes extends StatefulWidget {
  final ScrollController scrollController;
  final int id;
  const Episodes({
    super.key,
    required this.id,
    required this.scrollController,
  });

  @override
  State<Episodes> createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  bool isLoading = false;
  bool hasNextPage = true;
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AnimeDetailsBloc, AnimeDetailsState>(
          listener: (context, state) {
            if (state is FailedAnimeDetails) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
            if (state is AnimeEpisodesSuccess) {
              page = page + 1;
              widget.scrollController.addListener(() async {
                if (widget.scrollController.position.pixels ==
                        widget.scrollController.position.maxScrollExtent &&
                    !isLoading &&
                    hasNextPage) {
                  isLoading = true;
                  BlocProvider.of<AnimeDetailsBloc>(context)
                      .add(GetAnimeEpisodesPagination(
                    animeEpisodeModel: state.animeEpisodeModel,
                    id: widget.id,
                    page: page,
                  ));
                }
              });
            }
          },
        )
      ],
      child: BlocBuilder<AnimeDetailsBloc, AnimeDetailsState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AnimeEpisodesSuccess) {
            return ListView(
              controller: widget.scrollController,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: state.animeEpisodeModel.length,
                  itemBuilder: (context, index) {
                    hasNextPage = state.animeEpisodeModel.last.hasNextPage;
                    isLoading = false;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.all(2.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        shadowColor: Colors.transparent,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Episode  ',
                                style: textStyle2Color2,
                              ),
                              Text(
                                state.animeEpisodeModel[index].id.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11.5.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            state.animeEpisodeModel[index].title,
                            style: textStyle3ColorHeight,
                          ),
                          Row(
                            children: [
                              Text(
                                DateFormat.yMMMMEEEEd().format(
                                  DateTime.parse(
                                      state.animeEpisodeModel[index].date),
                                ),
                                style: TextStyle(
                                  color: customLightGrey,
                                  fontSize: 9.sp,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                '${state.animeEpisodeModel[index].score.toString()}/5',
                                style: TextStyle(
                                  color: customLightGrey,
                                  fontSize: 9.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) => const EpisodeDetail(),
                        );
                        BlocProvider.of<AnimeDetailsCubit>(context)
                            .getAnimeEpisodeDetails(
                          widget.id,
                          state.animeEpisodeModel[index].id,
                        );
                      },
                    );
                  },
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  height: state.animeEpisodeModel.isEmpty
                      ? 0.h
                      : state.animeEpisodeModel.last.hasNextPage
                          ? 5.h
                          : 0.h,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class EpisodeDetail extends StatelessWidget {
  const EpisodeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(5.w),
      alignment: AlignmentDirectional.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(5.w),
        height: 70.h,
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: BlocBuilder<AnimeDetailsCubit, AnimeDetailsCubitState>(
          builder: (context, state) {
            if (state is AnimeEpisodeDetailSuccess) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text('title => ', style: textStyle2Color2),
                      Text(
                        state.animeEpisodeDetailsModel.title,
                        style: textStyle2Color,
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Text('jap title => ', style: textStyle2Color2),
                      Text(state.animeEpisodeDetailsModel.titleJap),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Text('aired => ', style: textStyle2Color2),
                      Text(
                        DateFormat.yMMMMEEEEd().format(
                          DateTime.parse(state.animeEpisodeDetailsModel.date),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Text('duration => ', style: textStyle2Color2),
                      Text(
                          '${(state.animeEpisodeDetailsModel.duration / 60).ceil().toString()} Mins'),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Text('filler => ', style: textStyle2Color2),
                      Text(
                        state.animeEpisodeDetailsModel.isFiller.toString(),
                        style: textStyle2Color,
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Text('recap => ', style: textStyle2Color2),
                      Text(
                        state.animeEpisodeDetailsModel.isRecap.toString(),
                        style: textStyle2Color,
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  AutoSizeText(
                    'synopsis => ${state.animeEpisodeDetailsModel.synopsis}',
                    maxLines: 20,
                    style: const TextStyle(
                      fontFamily: 'Fonstars',
                      color: Color.fromARGB(255, 92, 87, 87),
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
    );
  }
}

class ImageGallery extends StatelessWidget {
  const ImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(5.w),
      alignment: AlignmentDirectional.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(5.w),
        height: 30.h,
        width: 100.w,
        child: BlocBuilder<AnimeDetailsBloc, AnimeDetailsState>(
          builder: (context, state) {
            if (state is AnimeImageGallerySuccess) {
              if (state.animeImageGalleryModel.isEmpty) {
                return Container();
              } else {
                return GalleryImage(
                  imageUrls: List.generate(
                    state.animeImageGalleryModel.length,
                    (index) => state.animeImageGalleryModel[index].url,
                  ),
                  numOfShowImages: 6,
                );
              }
            } else if (state is AnimeCharacterPicturesSuccess) {
              if (state.animeCharacterImageModel.isEmpty) {
                return Container();
              } else {
                return GalleryImage(
                  imageUrls: List.generate(
                    state.animeCharacterImageModel.length,
                    (index) => state.animeCharacterImageModel[index].image,
                  ),
                  numOfShowImages: 6,
                );
              }
            } else if (state is MangaImageGallerySuccess) {
              return GalleryImage(
                imageUrls: List.generate(
                  state.mangaImageGalleryModel.length,
                  (index) => state.mangaImageGalleryModel[index].url,
                ),
                numOfShowImages: 6,
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

class VideoGallery extends StatelessWidget {
  final ScrollController scrollController;
  const VideoGallery({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeDetailsBloc, AnimeDetailsState>(
      builder: (context, state) {
        if (state is AnimeVideoGallerySuccess) {
          return ListView.builder(
            itemCount: state.animeVideoGalleryModel.length,
            controller: scrollController,
            itemBuilder: (context, index) {
              return Container(
                height: 30.h,
                width: 100.w,
                margin:
                    EdgeInsets.symmetric(vertical: 1.5.w, horizontal: 1.5.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    //alignment: AlignmentDirectional.center,
                    children: [
                      SizedBox(
                        height: 30.h,
                        width: 100.w,
                        child: CustomInternetImage(
                          url: state.animeVideoGalleryModel[index].image,
                        ),
                      ),
                      Container(
                        height: 30.h,
                        width: 100.w,
                        color: const Color.fromARGB(255, 88, 88, 88)
                            .withOpacity(0.4),
                      ),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: IconButton(
                          icon: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.pinkAccent,
                          ),
                          iconSize: 45.sp,
                          onPressed: () {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  insetPadding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: SizedBox(
                                    width: 100.w,
                                    height: 40.h,
                                    child: YoutubePlayer(
                                      controller: YoutubePlayerController(
                                        initialVideoId: state
                                            .animeVideoGalleryModel[index].id,
                                        flags: const YoutubePlayerFlags(
                                          autoPlay: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.bottomCenter,
                        margin: EdgeInsets.only(bottom: 4.w),
                        child: Text(
                          state.animeVideoGalleryModel[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class Reviews extends StatefulWidget {
  final String poster;
  final String title;
  final int id;
  const Reviews({
    super.key,
    required this.poster,
    required this.title,
    required this.id,
  });

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
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
    return MultiBlocListener(
      listeners: [
        BlocListener<AnimeDetailsBloc, AnimeDetailsState>(
          listener: (context, state) {
            if (state is FailedAnimeDetails) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
            if (state is AnimeReviewsSuccess) {
              page = page + 1;
              scrollController.addListener(() {
                if (scrollController.position.pixels ==
                        scrollController.position.maxScrollExtent &&
                    !isLoading &&
                    hasNextPage) {
                  isLoading = true;
                  BlocProvider.of<AnimeDetailsBloc>(context)
                      .add(GetAnimeReviewsPagination(
                    animeReviewsModel: state.animeReviewsModel,
                    id: widget.id,
                    page: page,
                  ));
                }
              });
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('REVIEWS'),
          centerTitle: true,
        ),
        body: BlocBuilder<AnimeDetailsBloc, AnimeDetailsState>(
          builder: (context, state) {
            if (state is AnimeReviewsSuccess) {
              return ListView(
                controller: scrollController,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.animeReviewsModel.length,
                    itemBuilder: (context, index) {
                      isLoading = false;
                      hasNextPage = state.animeReviewsModel.last.hasNextPage;
                      return Container(
                        width: 100.w,
                        height: 48.h,
                        margin: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 2.w),
                        padding: EdgeInsets.all(5.w),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 65.w,
                                  height: 6.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RatingStars(
                                        value: double.parse(
                                          state.animeReviewsModel[index].score
                                              .toString(),
                                        ),
                                        starCount: 10,
                                        maxValue: 10,
                                        valueLabelVisibility: false,
                                        starSize: 4.w,
                                        starColor: const Color.fromRGBO(
                                            255, 213, 79, 1),
                                      ),
                                      Text(
                                        widget.title,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: textStyle2,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CustomInternetImage(
                                      url: widget.poster,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              state.animeReviewsModel[index].review,
                              maxLines: 10,
                              textAlign: TextAlign.justify,
                              style: textStyle3ColorHeight,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 6.h,
                                  width: 6.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CustomInternetImage(
                                      url: state
                                          .animeReviewsModel[index].profile,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                SizedBox(
                                  width: 37.w,
                                  height: 6.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        state.animeReviewsModel[index].username,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: textStyle2,
                                      ),
                                      Text(
                                        DateFormat.yMMMMEEEEd().format(
                                            DateTime.parse(state
                                                .animeReviewsModel[index]
                                                .date)),
                                        maxLines: 10,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          height: 0.5.w,
                                          color: customDarkGrey,
                                          fontSize: 8.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                TextButton(
                                  onPressed: () {
                                    showFlexibleBottomSheet(
                                      context: context,
                                      minHeight: 0,
                                      initHeight: 0.5,
                                      maxHeight: 1,
                                      anchors: [0, 0.5, 1],
                                      bottomSheetBorderRadius:
                                          const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      builder: (context, scrollController,
                                          bottomSheetOffset) {
                                        return ReviewsMore(
                                          controller: scrollController,
                                          index: index,
                                          poster: widget.poster,
                                          title: widget.title,
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Continue Reading',
                                        style: textStyle4,
                                      ),
                                      SizedBox(width: 1.w),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 15.sp,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: state.animeReviewsModel.isEmpty
                        ? 0.h
                        : state.animeReviewsModel.last.hasNextPage
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

class ReviewsMore extends StatelessWidget {
  final ScrollController controller;
  final int index;
  final String poster;
  final String title;
  const ReviewsMore({
    super.key,
    required this.controller,
    required this.index,
    required this.poster,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeDetailsBloc, AnimeDetailsState>(
      builder: (context, state) {
        state as AnimeReviewsSuccess;
        return Container(
          padding: EdgeInsets.all(4.w),
          height: 100.h,
          child: ListView(
            controller: controller,
            children: [
              SizedBox(
                height: 20.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingStars(
                            value: double.parse(
                              state.animeReviewsModel[index].score.toString(),
                            ),
                            starCount: 10,
                            maxValue: 10,
                            valueLabelVisibility: false,
                            starSize: 5.w,
                            starColor: const Color.fromRGBO(255, 213, 79, 1),
                          ),
                          Text(
                            title,
                            maxLines: 1,
                            softWrap: false,
                            style: textStyle1,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 8.h,
                                width: 8.h,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CustomInternetImage(
                                    url: state.animeReviewsModel[index].profile,
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.w),
                              SizedBox(
                                height: 10.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      state.animeReviewsModel[index].username,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: textStyle2,
                                    ),
                                    Text(
                                      DateFormat.yMMMMEEEEd().format(
                                          DateTime.parse(
                                              state.animeReviewsModel[0].date)),
                                      maxLines: 10,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        height: 0.5.w,
                                        color: const Color.fromARGB(
                                            255, 92, 87, 87),
                                        fontSize: 8.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 4.w),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CustomInternetImage(
                        url: poster,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                state.animeReviewsModel[index].review,
                textAlign: TextAlign.justify,
                style: textStyle3ColorHeight,
              ),
            ],
          ),
        );
      },
    );
  }
}
