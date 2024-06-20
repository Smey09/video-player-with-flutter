import 'package:flutter/material.dart';
import 'package:movie_from_github/models/movieModel.dart';
import 'package:movie_from_github/screens/display/videoPlay.dart';

class SearchScreen extends StatefulWidget {
  final MovieModel movieModel;

  const SearchScreen({super.key, required this.movieModel});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late List<Result> _searchResults;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchResults = [];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _isSearching = true;
      _searchResults = widget.movieModel.search(query);
    });
  }

  void _clearSearch() {
    setState(() {
      _isSearching = false;
      _searchResults.clear();
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search movies...',
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _clearSearch,
            ),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              _performSearch(value);
            }
          },
        ),
      ),
      body: _isSearching
          ? _buildSearchResults()
          : const Center(
              child: Text('Start searching by typing in the search bar.'),
            ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => YoutubePlayerScreen(
                  movie: result,
                  movies: widget.movieModel.results,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border:
                  Border.all(width: 1, color: Colors.black.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      result.releaseDate,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${result.voteAverage}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.red.withOpacity(0.8),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Viewers: ",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          result.formattedVoteCount,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.red.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      result.typeMovie,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
