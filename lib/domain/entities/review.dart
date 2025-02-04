// lib/domain/entities/review.dart
class Review {
  final String username;
  final String comment;
  final double rating;

  Review({
    required this.username,
    required this.comment,
    required this.rating,
  });
}
