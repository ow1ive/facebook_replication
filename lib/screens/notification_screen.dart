import '../widgets/custom_info.dart' as notif;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/comment.dart';
import '../services/post_service.dart';
import '../services/comment_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final PostService _postService = PostService();
  final CommentService _commentService = CommentService();

  List<Comment> _notifications = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      final posts = await _postService.getPosts(limit: 5);
      final commentsPerPost = await Future.wait(
        posts.map((p) => _commentService.getCommentsByPostId(p.id)),
      );
      if (!mounted) return;
      setState(() {
        _notifications = commentsPerPost.expand((c) => c).toList();
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load notifications. Please try again later.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!));
    }

    return Container(
      color: Colors.white,
      width: ScreenUtil().screenWidth,
      child: ListView.separated(
        itemCount: _notifications.length,
        separatorBuilder: (_, _) => const Divider(),
        itemBuilder: (context, index) {
          final comment = _notifications[index];
          return notif.CustomInformation(
            name: comment.fullName.isNotEmpty
                ? comment.fullName
                : comment.username,
            post: 'commented on your post',
            description: comment.body,
            date: 'Just now',
            numOfLikes: comment.likes,
          );
        },
      ),
    );
  }
}
