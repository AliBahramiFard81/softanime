import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_character_actor_bloc.dart';
import 'package:main/bloc/anime_page_bloc.dart';
import 'package:main/bloc/manga_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/common/navigation_bloc_data.dart';
import 'package:main/pages/anime_page.dart';
import 'package:main/pages/characters_page.dart';
import 'package:main/pages/home_page.dart';
import 'package:main/pages/manga_page.dart';
import 'package:main/widgets/custom_internet_image.dart';
import 'package:sizer/sizer.dart';

class HomePageItemList extends StatelessWidget {
  final List type;
  final HomePageListType homePageListType;
  const HomePageItemList({
    super.key,
    required this.type,
    required this.homePageListType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 28.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 35.h,
            width: 40.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.all(2.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadowColor: Colors.transparent,
              ),
              onPressed: () {
                if (homePageListType == HomePageListType.anime) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnimePage(),
                      ));
                  animePagesId.add(type[index].id);
                  context.read<AnimePageBloc>().add(GetAnime(
                        id: type[index].id,
                      ));
                } else if (homePageListType == HomePageListType.character) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CharacterPage(),
                      ));
                  characterPageId.add(type[index].id);
                  BlocProvider.of<AnimeCharacterActorBloc>(context)
                      .add(GetAnimeCharacter(id: type[index].id));
                } else if (homePageListType == HomePageListType.manga) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MangaPage(),
                      ));
                  mangaPageId.add(type[index].id);
                  BlocProvider.of<MangaBloc>(context)
                      .add(GetManga(id: type[index].id));
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 23.h,
                    width: 40.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CustomInternetImage(
                        url: type[index].poster,
                      ),
                    ),
                  ),
                  Text(
                    type[index].title,
                    maxLines: 1,
                    softWrap: false,
                    style: textStyle2Color,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
