class AnimeMangaGenreModel {
  final int id;
  final String name;
  final int count;

  AnimeMangaGenreModel({
    required this.id,
    required this.name,
    required this.count,
  });

  factory AnimeMangaGenreModel.fromJson(Map<String, dynamic> json) {
    return AnimeMangaGenreModel(
      id: json['mal_id'],
      name: json['name'],
      count: json['count'],
    );
  }
}
