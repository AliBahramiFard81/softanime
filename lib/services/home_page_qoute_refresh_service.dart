// ignore_for_file: empty_catches
import 'dart:convert';

import 'package:main/models/anime_quotes_model.dart';
import 'package:http/http.dart' as http;

class HomePageAnimeQuoteRefreshService {
  Future<List<AnimeQuotesModel>?> refreshAnimeQuote() async {
    const animeQuotesUrl = 'https://animechan.xyz/api/quotes';

    try {
      // ANIME QUOTES SERVICE
      final animeQuoteResponse = await http.get(Uri.parse(animeQuotesUrl));
      final animeQuoteModel = List.generate(10, (index) {
        return AnimeQuotesModel.fromJson(
            jsonDecode(animeQuoteResponse.body)[index]);
      });
      return animeQuoteModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
