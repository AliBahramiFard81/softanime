import 'package:bloc/bloc.dart';
import 'package:main/models/search_model.dart';
import 'package:main/services/search_service.dart';
import 'package:main/widgets/home_page_appbar.dart';
import 'package:meta/meta.dart';

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  SearchPageBloc() : super(SearchPageInitial()) {
    on<GetSearchByName>((event, emit) async {
      emit(SearchPageLoading());
      final searchModel = await SearchService()
          .getSearchByName(event.query, 1, event.searchType.name.toString());
      if (searchModel == null) {
        emit(SearchPageFailed(error: 'failed to fetch retrying...'));
      } else {
        emit(SearchPageSuccess(searchModel: searchModel));
      }
    });
    on<GetSearchByNamePagination>((event, emit) async {
      final searchModel = await SearchService().getSearchByName(
          event.query, event.page, event.searchType.name.toString());
      if (searchModel == null) {
        emit(SearchPageFailed(error: 'failed to fetch retrying...'));
      } else {
        event.list.addAll(searchModel);
        emit(SearchPageSuccess(searchModel: event.list));
      }
    });
  }
}
