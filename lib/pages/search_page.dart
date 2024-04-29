import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_character_actor_bloc.dart';
import 'package:main/bloc/anime_page_bloc.dart';
import 'package:main/bloc/manga_bloc.dart';
import 'package:main/bloc/search_page_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/common/navigation_bloc_data.dart';
import 'package:main/pages/anime_page.dart';
import 'package:main/pages/characters_page.dart';
import 'package:main/pages/manga_page.dart';
import 'package:main/widgets/custom_internet_image.dart';
import 'package:main/widgets/home_page_appbar.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  final String query;
  final SearchType searchType;
  const SearchPage({
    super.key,
    required this.query,
    required this.searchType,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late ScrollController scrollController;
  bool isLoading = false;
  bool hasNextPage = true;
  int page = 1;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchPageBloc, SearchPageState>(
      listener: (context, state) {
        if (state is SearchPageFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
        if (state is SearchPageSuccess) {
          page = page + 1;
          scrollController.addListener(() {
            if (scrollController.position.pixels ==
                    scrollController.position.maxScrollExtent &&
                !isLoading &&
                hasNextPage) {
              isLoading = true;
              BlocProvider.of<SearchPageBloc>(context).add(
                GetSearchByNamePagination(
                  query: widget.query,
                  list: state.searchModel,
                  page: page,
                  searchType: widget.searchType,
                ),
              );
            }
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search result'),
          centerTitle: true,
        ),
        body: BlocBuilder<SearchPageBloc, SearchPageState>(
          builder: (context, state) {
            if (state is SearchPageSuccess) {
              return ListView(
                controller: scrollController,
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: (40.w / 30.h),
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.searchModel.length,
                    itemBuilder: (context, index) {
                      hasNextPage = state.searchModel.last.hasNextPage;
                      isLoading = false;
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
                            if (widget.searchType == SearchType.anime) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AnimePage(),
                                  ));
                              animePagesId.add(state.searchModel[index].id);
                              context.read<AnimePageBloc>().add(GetAnime(
                                    id: state.searchModel[index].id,
                                  ));
                            } else if (widget.searchType == SearchType.manga) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MangaPage(),
                                  ));
                              mangaPageId.add(state.searchModel[index].id);
                              BlocProvider.of<MangaBloc>(context).add(
                                  GetManga(id: state.searchModel[index].id));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CharacterPage(),
                                  ));
                              characterPageId.add(state.searchModel[index].id);
                              BlocProvider.of<AnimeCharacterActorBloc>(context)
                                  .add(GetAnimeCharacter(
                                      id: state.searchModel[index].id));
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 19.h,
                                width: 40.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CustomInternetImage(
                                    url: state.searchModel[index].poster,
                                  ),
                                ),
                              ),
                              Text(
                                state.searchModel[index].title,
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
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: state.searchModel.isEmpty
                        ? 0.h
                        : state.searchModel.last.hasNextPage
                            ? 5.h
                            : 0.h,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
