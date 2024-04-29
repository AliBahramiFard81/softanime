part of 'search_type_cubit.dart';

@immutable
sealed class SearchTypeState {}

final class SearchTypeInitial extends SearchTypeState {}

final class SearchTypeChanged extends SearchTypeState {
  final SearchType searchType;
  SearchTypeChanged({required this.searchType});
}
