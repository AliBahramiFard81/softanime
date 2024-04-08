import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';

class HomePageCarouselDetails extends StatelessWidget {
  final String text;
  final String icon;
  const HomePageCarouselDetails({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Iconify(
          icon,
          color: Colors.white,
          size: 15.sp,
        ),
        Container(width: 2.w),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
              overflow: TextOverflow.fade,
              fontFamily: 'Fonstars',
              color: Colors.white,
              fontSize: 9.sp,
            ),
          ),
        )
      ],
    );
  }
}
