import 'package:flutter/material.dart';
import 'package:main/common/font_styles.dart';
import 'package:sizer/sizer.dart';

class AnimeMangaPageDetailButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const AnimeMangaPageDetailButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.all(4.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            maxLines: 1,
            softWrap: false,
            style: textStyle1,
          ),
          const Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
