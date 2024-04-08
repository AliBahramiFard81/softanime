class AnimeQuotesModel {
  final String quote;
  final String anime;
  final String character;

  AnimeQuotesModel({
    required this.quote,
    required this.anime,
    required this.character,
  });

  factory AnimeQuotesModel.fromJson(Map<String, dynamic> json) {
    return AnimeQuotesModel(
      quote: json['quote'],
      anime: json['anime'],
      character: json['character'],
    );
  }
}
