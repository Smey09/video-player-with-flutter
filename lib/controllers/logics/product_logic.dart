import 'package:flutter/material.dart';
import 'package:movie_from_github/models/movieModel.dart';

class ProductLogic extends ChangeNotifier {
  final List<MovieModel> _favoriteList = [];
  List<MovieModel> get favoriteList => _favoriteList;

  void addToFavorite(MovieModel item) {
    _favoriteList.add(item);
    notifyListeners();
  }

  void removeFromFavorite(MovieModel item) {
    _favoriteList.remove(item);
    notifyListeners();
  }

  bool isFavorite(MovieModel item) {
    return _favoriteList.contains(item);
  }
}
