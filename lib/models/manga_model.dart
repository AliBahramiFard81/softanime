import 'package:main/models/anime_model.dart';

class MangaMainModel {
  final MangaModel mangaModel;
  final List<MangaCharacters> charactersModel;
  final List<MangaRecommendations> mangaRecommendations;
  MangaMainModel({
    required this.mangaModel,
    required this.charactersModel,
    required this.mangaRecommendations,
  });
}

class MangaModel {
  final int id;
  final String poster;
  final String title;
  final String type;
  final String status;
  final double score;
  final int scoredBy;
  final String synopsis;
  final String date;
  final String demographic;
  final List<Genres> genre;

  MangaModel({
    required this.id,
    required this.poster,
    required this.title,
    required this.type,
    required this.status,
    required this.score,
    required this.scoredBy,
    required this.date,
    required this.demographic,
    required this.genre,
    required this.synopsis,
  });

  factory MangaModel.fromJson(Map<String, dynamic> json) {
    return MangaModel(
      id: json['mal_id'],
      poster: json['images']['jpg']['large_image_url'],
      title: json['title'],
      type: json['type'] ?? 'unknown',
      status: json['status'] ?? 'unknown',
      score: json['score'] ?? 0.0,
      scoredBy: json['scored_by'] ?? 0,
      date: json['published']['from'] ?? 'unknown',
      genre: (json['genres'] as List<dynamic>).isEmpty
          ? []
          : List.generate((json['genres'] as List<dynamic>).length, (index) {
              return Genres.fromJson(json['genres'][index]);
            }),
      demographic: (json['demographics'] as List<dynamic>).isEmpty
          ? 'unknown'
          : json['demographics'][0]['name'],
      synopsis: json['synopsis'] ?? 'unknown',
    );
  }
}

class MangaCharacters {
  final int id;
  final String image;
  final String name;

  MangaCharacters({
    required this.id,
    required this.image,
    required this.name,
  });

  factory MangaCharacters.fromJson(Map<String, dynamic> json) {
    return MangaCharacters(
      id: json['character']['mal_id'],
      image: json['character']['images']['jpg']['image_url'],
      name: json['character']['name'],
    );
  }
}

class MangaRecommendations {
  final int id;
  final String poster;
  final String title;

  MangaRecommendations({
    required this.id,
    required this.poster,
    required this.title,
  });

  factory MangaRecommendations.fromJson(Map<String, dynamic> json) {
    return MangaRecommendations(
      id: json['mal_id'],
      poster: json['images']['jpg']['large_image_url'],
      title: json['title'],
    );
  }
}

class MangaImageGalleryModel {
  final String url;
  MangaImageGalleryModel({required this.url});

  factory MangaImageGalleryModel.fromJson(Map<String, dynamic> json) {
    return MangaImageGalleryModel(url: json['jpg']['large_image_url']);
  }
}

class MangaReviewsModel {
  final int id;
  final String date;
  final String review;
  final int score;
  final String profile;
  final String username;
  final bool hasNextPage;
  MangaReviewsModel({
    required this.id,
    required this.date,
    required this.review,
    required this.score,
    required this.profile,
    required this.username,
    required this.hasNextPage,
  });

  factory MangaReviewsModel.fromJson(
      Map<String, dynamic> json, bool hasNextPage) {
    return MangaReviewsModel(
      id: json['mal_id'],
      date: json['date'],
      review: json['review'],
      score: json['score'],
      profile: json['user']['images']['jpg']['image_url'],
      username: json['user']['username'],
      hasNextPage: hasNextPage,
    );
  }
}
