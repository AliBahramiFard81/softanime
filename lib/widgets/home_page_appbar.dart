import 'dart:io';
import 'package:main/common/navigation_bloc_data.dart';
import 'package:main/cubit/search_history_cubit.dart';
import 'package:main/database/main_database.dart';
import 'package:main/pages/anime_page.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/search_page_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/cubit/search_type_cubit.dart';
import 'package:main/pages/search_page.dart';
import 'package:sizer/sizer.dart';

class HomePageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(6.5.h);
}

enum SearchType { anime, manga, characters }

class _HomePageAppBarState extends State<HomePageAppBar> {
  final SearchController searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    SearchType searchType = SearchType.anime;
    searchController.addListener(() {
      if (searchController.isAttached) {
        BlocProvider.of<SearchHistoryCubit>(context).closedSearch();
      } else {
        print('called');
      }
    });
    return AppBar(
      leading: SearchAnchor(
        searchController: searchController,
        builder: (context, controller) {
          return IconButton(
            onPressed: () {
              /*
              final supabase = Supabase.instance.client;
              await supabase.auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoadingPage(),
                ),
              );
              */
              searchController.openView();
            },
            icon: const Icon(Icons.search_rounded),
          );
        },
        viewOnSubmitted: (value) async {
          BlocProvider.of<SearchPageBloc>(context).add(GetSearchByName(
            query: searchController.text,
            searchType: searchType,
          ));
          BlocProvider.of<SearchHistoryCubit>(context).closedSearch();
          final db = await MainDatabase().openDb();
          await db.transaction((txn) async {
            await txn.insert('searchHistory', {
              'title': searchController.text,
              'type': searchType.name.toString(),
            });
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(
                query: searchController.text,
                searchType: searchType,
              ),
            ),
          );
        },
        viewTrailing: [
          IconButton(
            onPressed: () {
              searchController.clear();
            },
            icon: const Icon(Icons.close_rounded),
          ),
          IconButton(
            onPressed: () async {
              BlocProvider.of<SearchPageBloc>(context).add(GetSearchByName(
                query: searchController.text,
                searchType: searchType,
              ));
              BlocProvider.of<SearchHistoryCubit>(context).closedSearch();
              final db = await MainDatabase().openDb();
              await db.transaction((txn) async {
                await txn.insert('searchHistory', {
                  'title': searchController.text,
                  'type': searchType.name.toString(),
                });
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(
                    query: searchController.text,
                    searchType: searchType,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.search_rounded),
          ),
        ],
        suggestionsBuilder:
            (BuildContext context, SearchController controller) async {
          return <Widget>[
            Container(
              margin: EdgeInsets.only(top: 4.w),
              height: 100.h,
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      'search type',
                      style: textStyle3,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(4.w),
                    child: BlocBuilder<SearchTypeCubit, SearchTypeState>(
                      builder: (context, state) {
                        return SegmentedButton<SearchType>(
                          segments: [
                            ButtonSegment(
                              value: SearchType.anime,
                              label: Text(
                                'Anime',
                                style: textStyle3,
                              ),
                              icon: const Icon(Icons.movie_creation_rounded),
                            ),
                            ButtonSegment(
                              value: SearchType.manga,
                              label: Text(
                                'Manga',
                                style: textStyle3,
                              ),
                              icon: const Icon(Icons.book),
                            ),
                            ButtonSegment(
                              value: SearchType.characters,
                              label: Text(
                                'Character',
                                style: textStyle3,
                              ),
                              icon: const Icon(Icons.person),
                            ),
                          ],
                          showSelectedIcon: false,
                          selected: state is SearchTypeChanged
                              ? {state.searchType}
                              : {SearchType.anime},
                          onSelectionChanged: (p0) {
                            BlocProvider.of<SearchTypeCubit>(context)
                                .onChanged(p0.first);
                            searchType = p0.first;
                          },
                        );
                      },
                    ),
                  ),
                  BlocBuilder<SearchHistoryCubit, SearchHistoryState>(
                    builder: (context, state) {
                      if (state is RemovedHistory) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              state.list.length > 10 ? 10 : state.list.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(state.list.elementAt(index)['title']),
                              subtitle:
                                  Text(state.list.elementAt(index)['type']),
                              leading: const Icon(Icons.history_rounded),
                              trailing: IconButton(
                                onPressed: () async {
                                  BlocProvider.of<SearchHistoryCubit>(context)
                                      .removeHistory(
                                          state.list.elementAt(index)['title']);
                                },
                                icon: const Icon(Icons.close_rounded),
                              ),
                              onTap: () {
                                BlocProvider.of<SearchPageBloc>(context)
                                    .add(GetSearchByName(
                                  query: state.list.elementAt(index)['title'],
                                  searchType: state.list
                                              .elementAt(index)['type'] ==
                                          'anime'
                                      ? SearchType.anime
                                      : state.list.elementAt(index)['type'] ==
                                              'manga'
                                          ? SearchType.manga
                                          : SearchType.characters,
                                ));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchPage(
                                      query:
                                          state.list.elementAt(index)['title'],
                                      searchType:
                                          state.list.elementAt(index)['type'] ==
                                                  'anime'
                                              ? SearchType.anime
                                              : state.list.elementAt(
                                                          index)['type'] ==
                                                      'manga'
                                                  ? SearchType.manga
                                                  : SearchType.characters,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              ),
            ),
          ];
        },
      ),
      title: Text(
        'SoftAnime',
        style: homePageAppbarText,
      ),
      centerTitle: true,
    );
  }
}
