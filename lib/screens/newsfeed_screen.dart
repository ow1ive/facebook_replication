import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/post_card.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../services/post_service.dart';
import '../services/user_service.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  final PostService _postService = PostService();
  final UserService _userService = UserService();

  final List<Post> _posts = [];
  final Map<int, User> _usersById = {};
  bool _isLoading = true;
  String? _error;

  static const List<String> _adImages = [
    "assets/images/catto.jpg",
    "assets/images/post.jpg",
    "assets/images/pisces.jpg",
    "assets/images/biand.jpg",
    "assets/images/oliver.jpg",
  ];

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    try {
      final posts = await _postService.getPosts(limit: 15);
      final userIds = posts.map((p) => p.userId).toSet();
      final users = await Future.wait(
        userIds.map((id) => _userService.getUserById(id)),
      );
      if (!mounted) return;
      setState(() {
        _posts
          ..clear()
          ..addAll(posts);
        _usersById.addEntries(users.map((u) => MapEntry(u.id, u)));
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load newsfeed. Please try again later.';
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

    final children = <Widget>[];
    for (var i = 0; i < _posts.length; i++) {
      final post = _posts[i];
      final user = _usersById[post.userId];

      children.add(
        NewsfeedCard(
          postId: post.id,
          userName: user?.fullName ?? 'Unknown user',
          postContent: post.body,
          date: 'Just now',
          numOfLikes: post.likes,
          avatarUrl: user?.image,
        ),
      );

      if ((i + 1) % 3 == 0) {
        children.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Text(
              "Advertisement",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
        );
        children.add(_adCarousel());
      }
    }

    children.add(SizedBox(height: 20.h));

    return ListView(children: children);
  }

  Widget _adCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 0.9,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
        aspectRatio: 0.9,
      ),
      items: _adImages.map(_adItem).toList(),
    );
  }

  Widget _adItem(String imagePath) {
    return NewsfeedCard(
      userName: "Sponsored",
      postContent: "",
      date: "",
      hasImage: true,
      imageUrl: imagePath,
      avatarUrl: "assets/images/profile.jpg",
      isAds: true,
      adsMarket: 'Ikaw na ito!',
    );
  }
}
