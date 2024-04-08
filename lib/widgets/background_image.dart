import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BackgroundImage extends StatelessWidget {
  final String image;
  const BackgroundImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.modulate,
      child: Stack(
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromARGB(255, 65, 64, 64),
            Color.fromRGBO(255, 255, 255, 0.9)
          ],
        ).createShader(
          Rect.fromLTRB(
            0,
            0,
            bounds.width,
            bounds.height,
          ),
        );
      },
    );
  }
}
