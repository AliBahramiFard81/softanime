import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_bloc.dart';
import 'package:main/widgets/home_page_quote_widget.dart';
import 'package:sizer/sizer.dart';

class HomePageQuoteCarousel extends StatelessWidget {
  const HomePageQuoteCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeBloc, AnimeState>(
      builder: (context, state) {
        if (state is AnimeHomeSuccess) {
          return SizedBox(
            height: 25.h,
            child: CarouselSlider.builder(
              itemCount: 10,
              itemBuilder: (context, index, realIndex) {
                return HomePageQuoteWidget(
                  index: index,
                );
              },
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                height: 48.h,
                scrollPhysics: const BouncingScrollPhysics(),
                viewportFraction: 1,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayCurve: Curves.easeInOutSine,
                onPageChanged: ((index, reason) async {}),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
