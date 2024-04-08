import 'package:flutter/material.dart';
import 'package:main/common/font_styles.dart';
import 'package:sizer/sizer.dart';

class AnimeMangaPageHeader extends StatelessWidget {
  final String title;
  const AnimeMangaPageHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.w, left: 4.w, right: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 60.w,
            child: Center(
              child: Text(
                title,
                maxLines: 1,
                softWrap: false,
                style: textStyle1Color,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
