class RecentAnimeEpisodesModel {
  final int id;
  final String title;
  final String poster;
  final bool hasNextPage;
  RecentAnimeEpisodesModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.hasNextPage,
  });

  factory RecentAnimeEpisodesModel.fromJson(
      Map<String, dynamic> json, bool hasNextPage) {
    return RecentAnimeEpisodesModel(
      id: json['entry']['mal_id'],
      title: json['entry']['title'],
      poster: json['entry']['images']['jpg']['large_image_url'],
      hasNextPage: hasNextPage,
    );
  }
}
