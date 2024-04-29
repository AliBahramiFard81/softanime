import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_page_bloc.dart';
import 'package:main/bloc/genres_page_bloc.dart';
import 'package:main/bloc/manga_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/common/navigation_bloc_data.dart';
import 'package:main/pages/anime_page.dart';
import 'package:main/pages/manga_page.dart';
import 'package:main/widgets/custom_internet_image.dart';
import 'package:sizer/sizer.dart';

class GenrePage extends StatefulWidget {
  final String type;
  final int id;
  final String title;
  const GenrePage({
    super.key,
    required this.id,
    required this.type,
    required this.title,
  });

  @override
  State<GenrePage> createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
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
    return BlocListener<GenresPageBloc, GenresPageState>(
      listener: (context, state) {
        if (state is GenresPageFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
        if (state is GenrePageSuccess) {
          page = page + 1;
          scrollController.addListener(() {
            if (scrollController.position.pixels ==
                    scrollController.position.maxScrollExtent &&
                !isLoading &&
                hasNextPage) {
              isLoading = true;
              BlocProvider.of<GenresPageBloc>(context).add(
                GetGenreTitlePagination(
                  id: widget.id,
                  list: state.genrePageModel,
                  page: page,
                  type: widget.type,
                ),
              );
            }
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: BlocBuilder<GenresPageBloc, GenresPageState>(
          builder: (context, state) {
            if (state is GenrePageSuccess) {
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
                    itemCount: state.genrePageModel.length,
                    itemBuilder: (context, index) {
                      hasNextPage = state.genrePageModel.last.hasNextPage;
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
                            if (widget.type == 'anime') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AnimePage(),
                                  ));
                              animePagesId.add(state.genrePageModel[index].id);
                              context.read<AnimePageBloc>().add(GetAnime(
                                    id: state.genrePageModel[index].id,
                                  ));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MangaPage(),
                                  ));
                              mangaPageId.add(state.genrePageModel[index].id);
                              BlocProvider.of<MangaBloc>(context).add(
                                  GetManga(id: state.genrePageModel[index].id));
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
                                    url: state.genrePageModel[index].poster,
                                  ),
                                ),
                              ),
                              Text(
                                state.genrePageModel[index].title,
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
                    height: state.genrePageModel.isEmpty
                        ? 0.h
                        : state.genrePageModel.last.hasNextPage
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
