import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:main/widgets/custom_internet_image.dart';
import 'package:sizer/sizer.dart';

class AnimeMangaPagePoster extends StatelessWidget {
  final String poster;
  const AnimeMangaPagePoster({
    super.key,
    required this.poster,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        SizedBox(
          width: 100.w,
          child: ShaderMask(
            blendMode: BlendMode.colorBurn,
            child: Stack(
              children: [
                SizedBox(
                  width: 100.w,
                  height: 60.h,
                  child: CustomInternetImage(
                    url: poster,
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    color:
                        const Color.fromARGB(255, 68, 68, 68).withOpacity(0.8),
                  ),
                ),
              ],
            ),
            shaderCallback: (bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 65, 64, 64),
                  Color.fromARGB(255, 65, 64, 64),
                  Color.fromARGB(255, 65, 64, 64),
                  Color.fromRGBO(255, 255, 255, 0.9)
                ],
              ).createShader(
                Rect.fromLTRB(
                  10,
                  10,
                  bounds.width,
                  bounds.height,
                ),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 55.h),
          height: 10.h,
          width: 100.w,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 255, 255, 0.1),
                  Color.fromRGBO(255, 255, 255, 1),
                ],
              ).createShader(
                Rect.fromLTRB(
                  0,
                  10,
                  bounds.width,
                  bounds.height,
                ),
              );
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10.h,
            left: 4.w,
            right: 4.w,
            bottom: 4.w,
          ),
          height: 60.h,
          width: 100.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CustomInternetImage(
              url: poster,
            ),
          ),
        ),
      ],
    );
  }
}
