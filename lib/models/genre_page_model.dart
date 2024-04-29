class GenrePageModel {
  final String title;
  final int id;
  final String poster;
  final bool hasNextPage;

  GenrePageModel({
    required this.id,
    required this.poster,
    required this.title,
    required this.hasNextPage,
  });

  factory GenrePageModel.fromJson(Map<String, dynamic> json, bool hasNextPage) {
    return GenrePageModel(
      id: json['mal_id'],
      poster: json['images']['jpg']['large_image_url'],
      title: json['title'],
      hasNextPage: hasNextPage,
    );
  }
}
