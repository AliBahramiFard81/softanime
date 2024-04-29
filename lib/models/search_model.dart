class SearchModel {
  final int id;
  final String poster;
  final String title;
  final bool hasNextPage;
  SearchModel({
    required this.id,
    required this.poster,
    required this.title,
    required this.hasNextPage,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json, bool hasNextPage) {
    return SearchModel(
      id: json['mal_id'],
      poster: json['images']['jpg']['image_url'],
      title: json['title'] ?? json['name'],
      hasNextPage: hasNextPage,
    );
  }
}
