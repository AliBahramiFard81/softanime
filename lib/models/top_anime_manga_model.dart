class TopAnimeMangaModel {
  final int id;
  final String title;
  final String poster;
  final bool hasNextPage;

  TopAnimeMangaModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.hasNextPage,
  });

  factory TopAnimeMangaModel.fromJson(
      Map<String, dynamic> json, bool hasNextPage) {
    return TopAnimeMangaModel(
      id: json['mal_id'],
      title: json['title'],
      poster: json['images']['jpg']['large_image_url'],
      hasNextPage: hasNextPage,
    );
  }
}
