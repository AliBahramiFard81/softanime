class TopCharacterModel {
  final int id;
  final String title;
  final String poster;

  TopCharacterModel({
    required this.id,
    required this.title,
    required this.poster,
  });

  factory TopCharacterModel.fromJson(Map<String, dynamic> json) {
    return TopCharacterModel(
      id: json['mal_id'],
      title: json['name'],
      poster: json['images']['jpg']['image_url'],
    );
  }
}
