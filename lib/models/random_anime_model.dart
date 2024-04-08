class RandomAnimeModel {
  final int id;
  final String title;
  final String poster;
  final String type;
  final String status;
  final String rating;
  final double score;
  final int popularity;
  RandomAnimeModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.type,
    required this.status,
    required this.rating,
    required this.score,
    required this.popularity,
  });

  factory RandomAnimeModel.fromJson(Map<String, dynamic> json) {
    return RandomAnimeModel(
      id: json['data']['mal_id'],
      title: json['data']['title'],
      poster: json['data']['images']['jpg']['large_image_url'],
      type: json['data']['type'] ?? '',
      status: json['data']['status'] ?? '',
      rating: json['data']['rating'] ?? '',
      score: double.tryParse((json['data']['score']).toString()) ?? 0.0,
      popularity: json['data']['popularity'] ?? 0,
    );
  }
}
