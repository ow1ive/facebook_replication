class Comment {
  final int id;
  final String body;
  final int postId;
  final int likes;
  final int userId;
  final String username;
  final String fullName;

  const Comment({
    required this.id,
    required this.body,
    required this.postId,
    this.likes = 0,
    required this.userId,
    required this.username,
    required this.fullName,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};
    return Comment(
      id: json['id'] ?? 0,
      body: json['body'] ?? '',
      postId: json['postId'] ?? 0,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      userId: user['id'] ?? 0,
      username: user['username'] ?? '',
      fullName: user['fullName'] ?? '',
    );
  }
}
