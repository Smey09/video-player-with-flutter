class MusicModel {
  final int page;
  final List<MusicResult> results;
  final int totalPages;
  final int totalResults;

  MusicModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    var resultsList = json['results'] as List;
    List<MusicResult> results =
        resultsList.map((i) => MusicResult.fromJson(i)).toList();

    return MusicModel(
      page: json['page'] ?? 0,
      results: results,
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }
}

class MusicResult {
  final int id;
  final String title;
  final String artist;
  final String image;
  final String type;
  final String dateRelease;
  final String description;
  final String country;
  final double rating;
  final String link;
  final String views;

  MusicResult({
    required this.id,
    required this.title,
    required this.artist,
    required this.image,
    required this.type,
    required this.dateRelease,
    required this.description,
    required this.country,
    required this.rating,
    required this.link,
    required this.views,
  });

  factory MusicResult.fromJson(Map<String, dynamic> json) {
    return MusicResult(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      image: json['image'] ?? '',
      type: json['type'] ?? '',
      dateRelease: json['date-release'] ?? '',
      description: json['description'] ?? '',
      country: json['country'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      link: json['link'] ?? '',
      views: json['views'] ?? '',
    );
  }
}
