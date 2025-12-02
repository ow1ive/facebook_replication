import 'package:flutter/material.dart';
import '../widgets/newsfeed_card.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        NewsfeedCard(
          userName: "Olive Vergara Musca",
          postContent: "Hi",
          date: "2 hours ago",
          numOfLikes: 100,
          avatarUrl: "assets/images/profile.jpg",

        ),
        NewsfeedCard(
          userName: "Leueil",
          postContent: "Hello!",
          date: "an hour ago",
          numOfLikes: 200,
          hasImage: true,
          avatarUrl: "assets/images/baby.jpg",
          imageUrl: "assets/images/flowers.jpg",
        ),
      ],
    );
  }
}
