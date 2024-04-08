import 'package:flutter/material.dart';
import 'package:main/common/font_styles.dart';
import 'package:sizer/sizer.dart';

class AnimeMangaPageHeaterTitle extends StatelessWidget {
  final String title;

  const AnimeMangaPageHeaterTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
      child: Text(
        title,
        maxLines: 1,
        softWrap: false,
        style: textStyle1,
      ),
    );
  }
}
