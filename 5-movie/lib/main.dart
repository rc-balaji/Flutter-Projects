import 'package:flutter/material.dart';

void main() {
  runApp(MyMovieApp());
}

class MyMovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Rating App',
      home: MovieScreen(),
    );
  }
}

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  List<Movie> _movies = [
    Movie(
        name: 'Inception',
        rating: 8.8,
        imageUrl: 'assets/images/inception.jpeg'),
    Movie(
        name: 'The Shawshank Redemption',
        rating: 9.3,
        imageUrl: 'assets/images/inception.jpeg'),
    Movie(
        name: 'The Dark Knight',
        rating: 9.0,
        imageUrl: 'assets/images/inception.jpeg'),
    Movie(
        name: 'Pulp Fiction',
        rating: 8.9,
        imageUrl: 'assets/images/inception.jpeg'),
    Movie(
        name: 'Forrest Gump',
        rating: 8.8,
        imageUrl: 'assets/images/inception.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Ratings'),
      ),
      body: ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          return MovieTile(movie: _movies[index]);
        },
      ),
    );
  }
}

class Movie {
  final String name;
  final double rating;
  final String imageUrl;

  Movie({required this.name, required this.rating, required this.imageUrl});
}

class MovieTile extends StatefulWidget {
  final Movie movie;

  const MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  bool _isLiked = false;
  int _userRating = 0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        widget.movie.imageUrl,
        width: 50,
        height: 100,
        fit: BoxFit.cover,
      ),
      title: Text(widget.movie.name),
      subtitle: Row(
        children: [
          Text('Rating: ${widget.movie.rating.toString()}'),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                _isLiked = !_isLiked;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.thumb_up),
            onPressed: () {
              setState(() {
                _userRating++;
              });
            },
          ),
          Text('$_userRating'),
          IconButton(
            icon: Icon(Icons.thumb_down),
            onPressed: () {
              setState(() {
                if (_userRating > 0) {
                  _userRating--;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
