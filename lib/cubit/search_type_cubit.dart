import 'package:bloc/bloc.dart';
import 'package:main/widgets/home_page_appbar.dart';
import 'package:meta/meta.dart';

part 'search_type_state.dart';

class SearchTypeCubit extends Cubit<SearchTypeState> {
  SearchTypeCubit() : super(SearchTypeInitial());

  void onChanged(SearchType searchType) {
    return emit(SearchTypeChanged(searchType: searchType));
  }
}
