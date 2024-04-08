import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomInternetImage extends StatefulWidget {
  final String url;
  const CustomInternetImage({
    super.key,
    required this.url,
  });

  @override
  State<CustomInternetImage> createState() => _CustomInternetImageState();
}

class _CustomInternetImageState extends State<CustomInternetImage> {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return ExtendedImage.network(
      widget.url,
      cache: true,
      enableLoadState: true,
      cacheRawData: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: brightness == Brightness.light
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
                size: 20,
              ),
            );
          case LoadState.completed:
            return ExtendedRawImage(
              fit: BoxFit.fill,
              image: state.extendedImageInfo?.image,
            );
          case LoadState.failed:
            return Container();
        }
      },
    );
  }
}
