import 'package:bloc/bloc.dart';
import 'package:main/database/main_database.dart';
import 'package:meta/meta.dart';

part 'search_history_state.dart';

class SearchHistoryCubit extends Cubit<SearchHistoryState> {
  SearchHistoryCubit() : super(SearchHistoryInitial());
  void removeHistory(String title) async {
    final db = await MainDatabase().openDb();
    await db.delete(
      'searchHistory',
      where: 'title = "$title"',
    );
    List<Map> list = await db.query('searchHistory');
    return emit(RemovedHistory(list: list));
  }

  void closedSearch() async {
    emit(LoadHistory());
    final db = await MainDatabase().openDb();
    List<Map> list = await db.query('searchHistory');
    return emit(RemovedHistory(list: list));
  }
}
