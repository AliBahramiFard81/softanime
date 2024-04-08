class RecommendedAnimeMangaModel {
  final int id;
  final String title;
  final String poster;
  final bool hasNextPage;

  RecommendedAnimeMangaModel({
    required this.id,
    required this.poster,
    required this.title,
    required this.hasNextPage,
  });

  factory RecommendedAnimeMangaModel.fromJson(Map<String, dynamic> json,
      int firstIndex, int secondIndex, bool hasNextPage) {
    return RecommendedAnimeMangaModel(
      id: json['data'][firstIndex]['entry'][secondIndex]['mal_id'],
      poster: json['data'][firstIndex]['entry'][secondIndex]['images']['jpg']
          ['large_image_url'],
      title: json['data'][firstIndex]['entry'][secondIndex]['title'],
      hasNextPage: hasNextPage,
    );
  }
}
