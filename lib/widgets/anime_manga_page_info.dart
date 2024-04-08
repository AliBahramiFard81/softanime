import 'package:flutter/material.dart';
import 'package:main/common/font_styles.dart';
import 'package:sizer/sizer.dart';

class AnimeMangaPageInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const AnimeMangaPageInfo({
    super.key,
    required this.icon,
    required this.text,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
          ),
          SizedBox(width: 2.w),
          Text(
            '$title => ',
            style: textStyle2,
          ),
          Text(
            text,
            style: textStyle2Color,
          )
        ],
      ),
    );
  }
}
