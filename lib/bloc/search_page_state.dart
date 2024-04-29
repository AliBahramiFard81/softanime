part of 'search_page_bloc.dart';

@immutable
sealed class SearchPageState {}

final class SearchPageInitial extends SearchPageState {}

final class SearchPageLoading extends SearchPageState {}

final class SearchPageFailed extends SearchPageState {
  final String error;
  SearchPageFailed({required this.error});
}

final class SearchPageSuccess extends SearchPageState {
  final List<SearchModel> searchModel;
  SearchPageSuccess({required this.searchModel});
}
