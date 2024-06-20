import 'package:intl/intl.dart';

class MovieModel {
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  MovieModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      page: json['page'],
      results:
          List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
      totalPages: json['total_pages'] ?? 1,
      totalResults: json['total_results'] ?? 0,
    );
  }

  // Method to search for movies by title
  List<Result> search(String query) {
    return results
        .where(
            (movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

class Result {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final String formattedVoteCount;
  final String posterPath;
  final String typeMovie;
  final String videoPlayId;

  Result({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.formattedVoteCount,
    required this.posterPath,
    required this.typeMovie,
    required this.videoPlayId,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
      formattedVoteCount: formatVoteCount(json['vote_count']),
      posterPath: json['poster_path'],
      typeMovie: json['type_movie'],
      videoPlayId: json['video_play_id'] ?? "",
    );
  }

  static String formatVoteCount(int voteCount) {
    if (voteCount >= 1000000000) {
      double count = voteCount / 1000000000;
      return '${count.toStringAsFixed(count.truncateToDouble() == count ? 0 : 1)}B';
    } else if (voteCount >= 1000000) {
      double count = voteCount / 1000000;
      return '${count.toStringAsFixed(count.truncateToDouble() == count ? 0 : 1)}M';
    } else if (voteCount >= 10000) {
      double count = voteCount / 1000;
      return '${count.toStringAsFixed(count.truncateToDouble() == count ? 0 : 1)}k';
    } else {
      return voteCount.toString();
    }
  }

  // static String formatVoteCount(int voteCount) {
  //   if (voteCount >= 1000000) {
  //     double count = voteCount / 1000000;
  //     return '${count.toStringAsFixed(count.truncateToDouble() == count ? 0 : 1)}M';
  //   } else if (voteCount >= 10000) {
  //     double count = voteCount / 1000;
  //     return '${count.toStringAsFixed(count.truncateToDouble() == count ? 0 : 1)}k';
  //   } else {
  //     return voteCount.toString();
  //   }
  // }

  // String formatReleaseDate() {
  //   final now = DateTime.now();
  //   final releaseDateTime = DateTime.parse(releaseDate);
  //   final difference = now.difference(releaseDateTime);
  //   if (difference.inHours < 24) {
  //     return "today ${DateFormat('jm').format(releaseDateTime.toLocal())}";
  //   } else {
  //     return '${difference.inDays} days ago';
  //   }
  // }

  static String formatReleaseDate(String releaseDate) {
    final now = DateTime.now();
    final releaseDateTime = DateTime.parse(releaseDate);
    final difference = now.difference(releaseDateTime);

    if (difference.inHours < 24) {
      return "today ${DateFormat('jm').format(releaseDateTime.toLocal())}";
    } else if (difference.inDays < 30) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      final approxMonths = (difference.inDays / 30).round();
      return '$approxMonths month${approxMonths > 1 ? 's' : ''} ago';
    } else {
      final years = difference.inDays ~/ 365;
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }
}
