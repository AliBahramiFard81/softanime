import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';
import 'package:sizer/sizer.dart';

class AnimeMangaPageRating extends StatelessWidget {
  final String score;
  final String scoreBy;
  const AnimeMangaPageRating({
    super.key,
    required this.score,
    required this.scoreBy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4.w, right: 4.w),
      child: Row(
        children: [
          RatingStars(
            value: double.parse(score),
            starCount: 10,
            maxValue: 10,
            starSize: 4.w,
            starColor: const Color.fromRGBO(255, 213, 79, 1),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 1.5.w),
            width: 4.w,
            height: 0.5.w,
            color: Colors.grey,
          ),
          Iconify(
            FluentMdl2.people,
            color: Colors.black,
            size: 15.sp,
          ),
          Container(width: 2.w),
          Flexible(
            child: Text(
              scoreBy,
              softWrap: false,
              style: TextStyle(
                overflow: TextOverflow.fade,
                fontFamily: 'Fonstars',
                color: Colors.black,
                fontSize: 9.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
