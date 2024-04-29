import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/genres_page_bloc.dart';
import 'package:main/cubit/all_genres_cubit.dart';
import 'package:main/pages/genre_page.dart';
import 'package:main/widgets/anime_manga_page_detail_button.dart';

class AllGenresPage extends StatelessWidget {
  final String type;
  const AllGenresPage({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return BlocListener<AllGenresCubit, AllGenresState>(
      listener: (context, state) {
        if (state is AllGenresPageFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Genres'),
          centerTitle: true,
        ),
        body: BlocBuilder<AllGenresCubit, AllGenresState>(
          builder: (context, state) {
            if (state is AllGenresPageSuccess) {
              return ListView.builder(
                itemCount: state.animeMangaGenresModel.length,
                itemBuilder: (context, index) {
                  return AnimeMangaPageDetailButton(
                    title:
                        '${state.animeMangaGenresModel[index].name}(${state.animeMangaGenresModel[index].count})',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GenrePage(
                            id: state.animeMangaGenresModel[index].id,
                            title: state.animeMangaGenresModel[index].name,
                            type: type,
                          ),
                        ),
                      );
                      BlocProvider.of<GenresPageBloc>(context).add(
                        GetGenreTitle(
                          id: state.animeMangaGenresModel[index].id,
                          type: type,
                        ),
                      );
                    },
                  );
                },
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
