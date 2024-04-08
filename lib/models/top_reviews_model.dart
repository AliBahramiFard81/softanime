class TopReviewsModel {
  final int id;
  final String date;
  final String review;
  final int score;
  final String poster;
  final String profile;
  final String username;
  final String title;

  TopReviewsModel({
    required this.id,
    required this.date,
    required this.review,
    required this.score,
    required this.poster,
    required this.profile,
    required this.username,
    required this.title,
  });

  factory TopReviewsModel.fromJson(Map<String, dynamic> json) {
    return TopReviewsModel(
      id: json['entry']['mal_id'],
      date: json['date'],
      review: json['review'],
      score: json['score'],
      poster: json['entry']['images']['jpg']['large_image_url'],
      profile: json['user']['images']['jpg']['image_url'],
      username: json['user']['username'],
      title: json['entry']['title'],
    );
  }
}
