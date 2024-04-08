import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:intl/intl.dart';
import 'package:main/bloc/anime_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/widgets/custom_internet_image.dart';
import 'package:sizer/sizer.dart';

class HomePageReviewsMore extends StatelessWidget {
  final ScrollController controller;
  final int index;
  const HomePageReviewsMore({
    super.key,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeBloc, AnimeState>(
      builder: (context, state) {
        state as AnimeHomeSuccess;
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
                              state.homePageModel.topReviewsModel[index].score
                                  .toString(),
                            ),
                            starCount: 10,
                            maxValue: 10,
                            valueLabelVisibility: false,
                            starSize: 5.w,
                            starColor: const Color.fromRGBO(255, 213, 79, 1),
                          ),
                          Text(
                            state.homePageModel.topReviewsModel[index].title,
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
                                    url: state.homePageModel
                                        .topReviewsModel[index].profile,
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
                                      state.homePageModel.topReviewsModel[index]
                                          .username,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: textStyle2,
                                    ),
                                    Text(
                                      DateFormat.yMMMMEEEEd().format(
                                          DateTime.parse(state.homePageModel
                                              .topReviewsModel[0].date)),
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
                        url: state.homePageModel.topReviewsModel[index].poster,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                state.homePageModel.topReviewsModel[index].review,
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
