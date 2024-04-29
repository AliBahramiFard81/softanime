part of 'search_page_bloc.dart';

@immutable
sealed class SearchPageEvent {}

final class GetSearchByName extends SearchPageEvent {
  final String query;
  final SearchType searchType;
  GetSearchByName({
    required this.query,
    required this.searchType,
  });
}

final class GetSearchByNamePagination extends SearchPageEvent {
  final String query;
  final int page;
  final SearchType searchType;
  final List<SearchModel> list;
  GetSearchByNamePagination({
    required this.query,
    required this.list,
    required this.page,
    required this.searchType,
  });
}
