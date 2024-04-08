import 'package:bloc/bloc.dart';
import 'package:main/models/anime_quotes_model.dart';
import 'package:main/services/home_page_qoute_refresh_service.dart';
import 'package:meta/meta.dart';

part 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit() : super(QuotesInitial());

  void quotesRefresh() async {
    final quoteRefreshedModel =
        await HomePageAnimeQuoteRefreshService().refreshAnimeQuote();

    if (quoteRefreshedModel == null) {
      return;
    } else {
      return emit(QuotesRefreshed(animeQuotesModel: quoteRefreshedModel));
    }
  }
}
