class AnimeCharactersMainModel {
  final AnimeCharacter animeCharacter;
  final List<AnimeCharacterAnime> animeCharacterAnime;
  final List<AnimeCharacterManga> animeCharacterManga;
  final List<AnimeCharacterActor> animeCharacterActor;

  AnimeCharactersMainModel({
    required this.animeCharacter,
    required this.animeCharacterAnime,
    required this.animeCharacterManga,
    required this.animeCharacterActor,
  });
}

class AnimeCharacter {
  final int id;
  final String image;
  final String name;
  final String japName;
  final String about;

  AnimeCharacter({
    required this.id,
    required this.image,
    required this.name,
    required this.japName,
    required this.about,
  });

  factory AnimeCharacter.fromJson(Map<String, dynamic> json) {
    return AnimeCharacter(
      id: json['mal_id'],
      image: json['images']['jpg']['image_url'],
      name: json['name'],
      japName: json['name_kanji'],
      about: json['about'],
    );
  }
}

class AnimeCharacterAnime {
  final int id;
  final String poster;
  final String title;

  AnimeCharacterAnime({
    required this.id,
    required this.poster,
    required this.title,
  });

  factory AnimeCharacterAnime.fromJson(Map<String, dynamic> json) {
    return AnimeCharacterAnime(
      id: json['mal_id'],
      poster: json['images']['jpg']['large_image_url'],
      title: json['title'],
    );
  }
}

class AnimeCharacterManga {
  final int id;
  final String poster;
  final String title;

  AnimeCharacterManga({
    required this.id,
    required this.poster,
    required this.title,
  });

  factory AnimeCharacterManga.fromJson(Map<String, dynamic> json) {
    return AnimeCharacterManga(
      id: json['mal_id'],
      poster: json['images']['jpg']['large_image_url'],
      title: json['title'],
    );
  }
}

class AnimeCharacterActor {
  final int id;
  final String poster;
  final String title;

  AnimeCharacterActor({
    required this.id,
    required this.poster,
    required this.title,
  });

  factory AnimeCharacterActor.fromJson(Map<String, dynamic> json) {
    return AnimeCharacterActor(
      id: json['mal_id'],
      poster: json['images']['jpg']['image_url'],
      title: json['name'],
    );
  }
}

class AnimeCharacterImageModel {
  final String image;
  AnimeCharacterImageModel({required this.image});

  factory AnimeCharacterImageModel.fromJson(Map<String, dynamic> json) {
    return AnimeCharacterImageModel(image: json['jpg']['image_url']);
  }
}
