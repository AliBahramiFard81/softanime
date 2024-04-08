class AnimeMainModel {
  final AnimeModel animeModel;
  final List<Characters> characters;
  final List<AnimeRecommendations> recommendations;
  AnimeMainModel({
    required this.animeModel,
    required this.characters,
    required this.recommendations,
  });
}

class AnimeModel {
  final int id;
  final String poster;
  final String trailer;
  final String title;
  final String type;
  final String source;
  final int episodes;
  final String status;
  final String duration;
  final String rating;
  final double score;
  final int popularity;
  final String synopsis;
  final int year;
  final List<Genres> genres;
  final String demographic;
  AnimeModel({
    required this.id,
    required this.poster,
    required this.trailer,
    required this.title,
    required this.type,
    required this.source,
    required this.episodes,
    required this.status,
    required this.duration,
    required this.rating,
    required this.score,
    required this.popularity,
    required this.synopsis,
    required this.year,
    required this.genres,
    required this.demographic,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      id: json['mal_id'],
      poster: json['images']['jpg']['large_image_url'],
      trailer: json['trailer']['url'] ?? 'none',
      title: json['title'],
      type: json['type'] ?? 'unknown',
      source: json['source'] ?? 'unknown',
      episodes: json['episodes'] ?? 0,
      status: json['status'] ?? 'unknown',
      duration: json['duration'] ?? 'unknown',
      rating: json['rating'] ?? '-',
      score: double.parse(json['score'].toString()),
      popularity: json['scored_by'] ?? 6969,
      synopsis: json['synopsis'] ?? 'unknown',
      year: json['year'] ?? 6969,
      genres: (json['genres'] as List<dynamic>).isEmpty
          ? []
          : List.generate((json['genres'] as List<dynamic>).length, (index) {
              return Genres.fromJson(json['genres'][index]);
            }),
      demographic: (json['demographics'] as List<dynamic>).isEmpty
          ? 'unknown'
          : json['demographics'][0]['name'],
    );
  }
}

class Genres {
  final int id;
  final String type;
  final String name;
  Genres({
    required this.id,
    required this.type,
    required this.name,
  });

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['mal_id'],
      type: json['type'],
      name: json['name'],
    );
  }
}

class Characters {
  final int id;
  final String name;
  final String image;
  final int actorId;
  final String voiceActor;
  final String actorImage;

  Characters({
    required this.id,
    required this.name,
    required this.image,
    required this.actorId,
    required this.actorImage,
    required this.voiceActor,
  });
  factory Characters.fromJson(Map<String, dynamic> json, bool hasVoice) {
    return Characters(
      id: json['character']['mal_id'],
      name: json['character']['name'],
      image: json['character']['images']['jpg']['image_url'],
      actorId: hasVoice ? json['voice_actors'][0]['person']['mal_id'] : 1,
      actorImage: hasVoice
          ? json['voice_actors'][0]['person']['images']['jpg']['image_url']
          : '',
      voiceActor: hasVoice ? json['voice_actors'][0]['person']['name'] : '',
    );
  }
}

class AnimeEpisodeModel {
  final int id;
  final String title;
  final String date;
  final double score;
  final bool isFiller;
  final bool hasNextPage;

  AnimeEpisodeModel({
    required this.id,
    required this.title,
    required this.date,
    required this.score,
    required this.isFiller,
    required this.hasNextPage,
  });
  factory AnimeEpisodeModel.fromJson(
      Map<String, dynamic> json, bool hasNextPage) {
    return AnimeEpisodeModel(
      id: json['mal_id'],
      title: json['title'],
      date: json['aired'],
      score: double.parse((json['score']).toString()).isFinite
          ? double.parse((json['score']).toString())
          : 0.0,
      isFiller: json['filler'],
      hasNextPage: hasNextPage,
    );
  }
}

class AnimeEpisodeDetailsModel {
  final String title;
  final String titleJap;
  final int duration;
  final String date;
  final String synopsis;
  final bool isFiller;
  final bool isRecap;
  AnimeEpisodeDetailsModel({
    required this.title,
    required this.titleJap,
    required this.duration,
    required this.date,
    required this.synopsis,
    required this.isFiller,
    required this.isRecap,
  });
  factory AnimeEpisodeDetailsModel.fromJson(Map<String, dynamic> json) {
    return AnimeEpisodeDetailsModel(
      title: json['title'] ?? '',
      titleJap: json['title_japanese'] ?? '',
      duration: json['duration'] ?? 0,
      date: json['aired'] ?? '',
      synopsis: json['synopsis'] ?? '',
      isFiller: json['filler'] ?? false,
      isRecap: json['recap'] ?? false,
    );
  }
}

class AnimeImageGalleryModel {
  final String url;
  AnimeImageGalleryModel({required this.url});

  factory AnimeImageGalleryModel.fromJson(Map<String, dynamic> json) {
    return AnimeImageGalleryModel(url: json['jpg']['large_image_url']);
  }
}

class AnimeVideoGalleryModel {
  final String title;
  final String type;
  final String id;
  final String image;
  AnimeVideoGalleryModel({
    required this.title,
    required this.type,
    required this.id,
    required this.image,
  });

  factory AnimeVideoGalleryModel.fromJson(Map<String, dynamic> json, int type) {
    // 0 is promo and 1 is music videos
    return AnimeVideoGalleryModel(
      title: json['title'],
      type: type == 0 ? 'promo' : 'music video',
      id: type == 0
          ? json['trailer']['youtube_id']
          : json['video']['youtube_id'],
      image: type == 0
          ? json['trailer']['images']['large_image_url']
          : json['video']['images']['large_image_url'],
    );
  }
}

class AnimeReviewsModel {
  final int id;
  final String date;
  final String review;
  final int score;
  final String profile;
  final String username;
  final bool hasNextPage;
  AnimeReviewsModel({
    required this.id,
    required this.date,
    required this.review,
    required this.score,
    required this.profile,
    required this.username,
    required this.hasNextPage,
  });

  factory AnimeReviewsModel.fromJson(
      Map<String, dynamic> json, bool hasNextPage) {
    return AnimeReviewsModel(
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

class AnimeRecommendations {
  final int id;
  final String poster;
  final String title;

  AnimeRecommendations({
    required this.id,
    required this.poster,
    required this.title,
  });

  factory AnimeRecommendations.fromJson(Map<String, dynamic> json) {
    return AnimeRecommendations(
      id: json['mal_id'],
      poster: json['images']['jpg']['large_image_url'],
      title: json['title'],
    );
  }
}
