import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/cubit/quotes_cubit.dart';
import 'package:sizer/sizer.dart';

class HomePageQuoteWidget extends StatelessWidget {
  final int index;
  const HomePageQuoteWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuotesCubit, QuotesState>(
      builder: (context, state) {
        if (state is QuotesInitial) {
          return BlocBuilder<AnimeBloc, AnimeState>(
            builder: (context, state) {
              if (state is AnimeHomeSuccess) {
                return Container(
                  width: 100.w,
                  height: 25.h,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.format_quote_rounded),
                      AutoSizeText(
                        state.homePageModel.animeQuotesModel[index].quote,
                        maxLines: 4,
                        style: const TextStyle(
                          fontFamily: 'Fonstars',
                          color: Color.fromARGB(255, 92, 87, 87),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 14.sp,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            state.homePageModel.animeQuotesModel[index]
                                .character,
                            style: textStyle2Color,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.movie,
                            size: 14.sp,
                          ),
                          SizedBox(width: 2.w),
                          SizedBox(
                            width: 75.w,
                            child: Text(
                              state.homePageModel.animeQuotesModel[index].anime,
                              maxLines: 1,
                              softWrap: false,
                              style: textStyle2Color,
                            ),
                          )
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
        } else if (state is QuotesRefreshed) {
          return Container(
            width: 100.w,
            height: 25.h,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.format_quote_rounded),
                AutoSizeText(
                  state.animeQuotesModel[index].quote,
                  maxLines: 4,
                  style: const TextStyle(
                    fontFamily: 'Fonstars',
                    color: Color.fromARGB(255, 92, 87, 87),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 14.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      state.animeQuotesModel[index].character,
                      style: textStyle2Color,
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.movie,
                      size: 14.sp,
                    ),
                    SizedBox(width: 2.w),
                    SizedBox(
                      width: 75.w,
                      child: Text(
                        state.animeQuotesModel[index].anime,
                        maxLines: 1,
                        softWrap: false,
                        style: textStyle2Color,
                      ),
                    )
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
