class TopActorsModel {
  final int id;
  final String title;
  final String poster;

  TopActorsModel({
    required this.id,
    required this.title,
    required this.poster,
  });

  factory TopActorsModel.fromJson(Map<String, dynamic> json) {
    return TopActorsModel(
      id: json['mal_id'],
      title: json['name'],
      poster: json['images']['jpg']['image_url'],
    );
  }
}
