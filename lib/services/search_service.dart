import 'dart:convert';
import 'package:main/models/search_model.dart';
import 'package:http/http.dart' as http;

class SearchService {
  Future<List<SearchModel>?> getSearchByName(
      String query, int page, String searchType) async {
    final url = 'https://api.jikan.moe/v4/$searchType?q=$query&page=$page';
    try {
      final response = await http.get(Uri.parse(url));
      final searchResult = List.generate(
          (jsonDecode(response.body)['data'] as List<dynamic>).length, (index) {
        return SearchModel.fromJson(
          jsonDecode(response.body)['data'][index],
          jsonDecode(response.body)['pagination']['has_next_page'],
        );
      });
      return searchResult;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
