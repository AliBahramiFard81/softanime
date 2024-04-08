import 'package:flutter/material.dart';
import 'package:main/common/font_styles.dart';
import 'package:sizer/sizer.dart';

class HomePageListHeader extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;
  const HomePageListHeader({
    super.key,
    required this.title,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            maxLines: 1,
            softWrap: false,
            style: textStyle1,
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(buttonText),
          )
        ],
      ),
    );
  }
}
