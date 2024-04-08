part of 'quotes_cubit.dart';

@immutable
sealed class QuotesState {}

final class QuotesInitial extends QuotesState {}

final class QuotesRefreshed extends QuotesState {
  final List<AnimeQuotesModel> animeQuotesModel;
  QuotesRefreshed({required this.animeQuotesModel});
}
