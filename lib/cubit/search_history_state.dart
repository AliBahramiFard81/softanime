part of 'search_history_cubit.dart';

@immutable
sealed class SearchHistoryState {}

final class SearchHistoryInitial extends SearchHistoryState {}

final class RemovedHistory extends SearchHistoryState {
  final List<Map> list;
  RemovedHistory({required this.list});
}
final class LoadHistory extends SearchHistoryState{}