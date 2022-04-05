import 'dart:convert';

class Movie {
  String title;
  String posterUrl;
  String imdbId;
  String rating;
  String genre;
  Movie({
    required this.title,
    required this.posterUrl,
    required this.imdbId,
    required this.rating,
    required this.genre,
  });

  Movie copyWith({
    String? title,
    String? posterUrl,
    String? imdbId,
    String? rating,
    String? genre,
  }) {
    return Movie(
      title: title ?? this.title,
      posterUrl: posterUrl ?? this.posterUrl,
      imdbId: imdbId ?? this.imdbId,
      rating: rating ?? this.rating,
      genre: genre ?? this.genre,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'posterUrl': posterUrl,
      'imdbId': imdbId,
      'rating': rating,
      'genre': genre,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      posterUrl: map['posterUrl'] ?? '',
      imdbId: map['imdbId'] ?? '',
      rating: map['rating'] ?? '',
      genre: map['genre'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Movie(title: $title, posterUrl: $posterUrl, imdbId: $imdbId, rating: $rating, genre: $genre)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Movie &&
      other.title == title &&
      other.posterUrl == posterUrl &&
      other.imdbId == imdbId &&
      other.rating == rating &&
      other.genre == genre;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      posterUrl.hashCode ^
      imdbId.hashCode ^
      rating.hashCode ^
      genre.hashCode;
  }
}
