
// models/post.dart
class Post {
  final String id;
  final String title;
  final String content;
  final String username;
  final String userAvatar;
  final int upvotes;
  final int downvotes;
  final int comments;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.username,
    required this.userAvatar,
    required this.upvotes,
    required this.downvotes,
    required this.comments,
  });
}