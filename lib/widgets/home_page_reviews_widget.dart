import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:intl/intl.dart';
import 'package:main/bloc/anime_bloc.dart';
import 'package:main/common/colors.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/widgets/custom_internet_image.dart';
import 'package:main/widgets/home_page_reviews_more.dart';
import 'package:sizer/sizer.dart';

class HomePageReviewsWidget extends StatelessWidget {
  final int index;
  const HomePageReviewsWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeBloc, AnimeState>(
      builder: (context, state) {
        if (state is AnimeHomeSuccess) {
          return Container(
            width: 100.w,
            height: 48.h,
            margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingStars(
                            value: double.parse(
                              state.homePageModel.topReviewsModel[index].score
                                  .toString(),
                            ),
                            starCount: 10,
                            maxValue: 10,
                            valueLabelVisibility: false,
                            starSize: 4.w,
                            starColor: const Color.fromRGBO(255, 213, 79, 1),
                          ),
                          Text(
                            state.homePageModel.topReviewsModel[index].title,
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
                          url:
                              state.homePageModel.topReviewsModel[index].poster,
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  state.homePageModel.topReviewsModel[index].review,
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
                              .homePageModel.topReviewsModel[index].profile,
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    SizedBox(
                      width: 37.w,
                      height: 6.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            state.homePageModel.topReviewsModel[index].username,
                            maxLines: 1,
                            softWrap: false,
                            style: textStyle2,
                          ),
                          Text(
                            DateFormat.yMMMMEEEEd().format(DateTime.parse(state
                                .homePageModel.topReviewsModel[index].date)),
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
                          bottomSheetBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          builder:
                              (context, scrollController, bottomSheetOffset) {
                            return HomePageReviewsMore(
                              controller: scrollController,
                              index: index,
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
        } else {
          return Container();
        }
      },
    );
  }
}
